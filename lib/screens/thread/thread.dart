import 'dart:developer';

import 'package:find_friend/models/thread.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/thread/threadContents.dart';
import 'package:find_friend/screens/thread/threadRegister.dart';
import 'package:find_friend/services/thread.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadScreen extends StatefulWidget {
  const ThreadScreen({super.key});
  @override
  ThreadScreenState createState() => ThreadScreenState();
}

class ThreadScreenState extends State<ThreadScreen> {
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final ThreadProvider threadProvider = Get.put(ThreadProvider());

  final ScrollController _scrollController = ScrollController();

  final ThreadService threadService = ThreadService();

  @override
  void initState() {
    log('initState', name: 'ThreadScreen');
    super.initState();
    threadProvider.initThreadList();
  }

  @override
  void dispose() {
    log('dispose', name: 'ThreadScreen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        threadProvider.getNextThreadList();
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const CustomTextWidget(
          text: 'スレット一覧',
          kind: 'headTitle',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              log('add thread');

              if (userInfoProvider.point < THREAD_MAKE_NEED_POINT) {
                CustomSnackbar.showErrorSnackbar(
                  title: '活動ポイントが足りません',
                  error: Exception('支援ページでポイントを獲得してください'),
                );
                return;
              }
              Get.to(
                () => ThreadCreateForm(),
                transition: Transition.rightToLeft,
              );
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            color: Colors.blue,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.blue[200]),
              iconSize: MaterialStateProperty.all(40),
            ),
          )
        ],
      ),
      body: Obx(() => threadProvider.threadList.isEmpty
          ? const Center(
              child: Center(
                child: CustomTextWidget(text: 'スレットがありません', kind: 'listTitle'),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: threadProvider.threadList.length,
              itemBuilder: (BuildContext context, int index) {
                return _renderThreadList(threadProvider.threadList[index]);
              },
            )),
    );
  }

  InkWell _renderThreadList(ThreadTable thread) {
    return InkWell(
      onTap: () {
        Get.to(
          () => const ThreadContentsScreen(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.size,
          arguments: thread,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          color: Colors.white,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                color: Colors.black54,
              ),
            ),
            title: CustomTextWidget(
              text: thread.title.toString(),
              kind: 'listTitle',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
