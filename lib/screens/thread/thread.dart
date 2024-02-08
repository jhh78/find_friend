import 'dart:developer';

import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/screens/thread/threadDetail.dart';
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
              },
              icon: const Icon(Icons.add_circle_outline_rounded),
              color: Colors.black54,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.blue[200]),
                iconSize: MaterialStateProperty.all(40),
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _renderThreadList(context, index);
        },
      ),
    );
  }

  GestureDetector _renderThreadList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ThreadDetailScreen(),
          transition: Transition.circularReveal,
          arguments: {'key': index},
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Text('$index'),
      ),
    );
  }
}
