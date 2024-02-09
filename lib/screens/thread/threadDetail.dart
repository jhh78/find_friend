import 'dart:developer';

import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadDetailScreen extends StatelessWidget {
  ThreadDetailScreen({super.key});

  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CustomBackGroundImageWidget(
        type: 'bg',
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: CustomTextWidget(
            text: Get.arguments.title,
            kind: 'headTitle2',
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          actions: _renderAppbarActions(),
        ),
        body: Center(
          child: Text(
            'Thread Detail Screen \n ${Get.arguments.id}',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      )
    ]);
  }

  List<Widget>? _renderAppbarActions() {
    // TODO: 방을 작성한 사람은 해당 방을 삭제할 권한을 가진다

    // return null;
    return [
      IconButton(
        icon: const Icon(Icons.remove_circle_outline_outlined),
        color: Colors.red,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.red[200]),
          iconSize: MaterialStateProperty.all(30),
        ),
        onPressed: () {
          Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('スレッtを削除しますか？'),
              content: const Text('このすれっとを削除すると元に戻すことはできません\n本当に削除しますか？'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    log('close');
                    Get.back();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    log('delete thread');
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
      )
    ].toList();
  }
}
