import 'dart:developer';

import 'package:find_friend/models/thread.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/thread/threadContents.dart';
import 'package:find_friend/screens/thread/threadRegister.dart';
import 'package:find_friend/services/thread.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadScreen extends StatelessWidget {
  ThreadScreen({super.key});
  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  final ScrollController _scrollController = ScrollController();

  final ThreadService threadService = ThreadService();

  @override
  Widget build(BuildContext context) {
    // _scrollController.addListener(() async {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     log('scrollController called ${_scrollController.position.pixels} ${_scrollController.position.maxScrollExtent}');

    //     final int nextPage = threadProvider.currentPage.value + 1;

    //     List<ThreadTable> response = await threadService.getThreadList(
    //         userInfoProvider.selectedSchoolList, nextPage, PAGE_PER_ITEM);

    //     if (response.isNotEmpty) {
    //       threadProvider.setCurrentPage(nextPage);
    //       for (ThreadTable item in response) {
    //         threadProvider.setThreadList(item);
    //       }
    //     }
    //   }
    // });
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
              ))
        ],
      ),
      body: Obx(
        () => ListView.builder(
          controller: _scrollController,
          itemCount: threadProvider.threadList.length,
          itemBuilder: (context, index) {
            return _renderThreadList(threadProvider.threadList[index]);
          },
        ),
      ),
    );
  }

  GestureDetector _renderThreadList(ThreadTable thread) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ThreadContentsScreen(),
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
