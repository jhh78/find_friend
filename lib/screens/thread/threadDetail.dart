import 'dart:developer';

import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/threadContents.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/thread/contsnts/contentsList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadDetailScreen extends StatelessWidget {
  ThreadDetailScreen({super.key});

  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final ThreadContentsProvider threadContentsProvider =
      Get.put(ThreadContentsProvider());

  final List<String> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    log('ThreadDetailScreen build ${Get.arguments.id}');
    return Stack(
      children: [
        const CustomBackGroundImageWidget(type: 'bg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            title: CustomTextWidget(
              text: Get.arguments.title,
              kind: 'label',
            ),
          ),
          body: ThreadContentsListWidget(
            scrollController: _scrollController,
          ),
        )
      ],
    );
  }
}
