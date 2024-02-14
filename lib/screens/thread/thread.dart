import 'dart:developer';

import 'package:find_friend/models/thread.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/screens/thread/threadDetail.dart';
import 'package:find_friend/screens/thread/threadRegister.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadScreen extends StatelessWidget {
  ThreadScreen({super.key});
  final ThreadProvider threadProvider = Get.put(ThreadProvider());

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black54,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.blue[200]),
                iconSize: MaterialStateProperty.all(40),
              ))
        ],
      ),
      body: Obx(
        () => ListView.builder(
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
          () => ThreadDetailScreen(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.circularReveal,
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
