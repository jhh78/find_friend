import 'dart:developer';

import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/widgets/common/messageSendForm.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadContentsMessageFormWidget extends StatelessWidget {
  final ScrollController scrollController;

  final ThreadContentsService _threadContentsService = ThreadContentsService();
  final TextEditingController _textController = TextEditingController();

  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final UsersService _usersService = UsersService();

  ThreadContentsMessageFormWidget({super.key, required this.scrollController});

  void _onSendMessage() async {
    try {
      if (userInfoProvider.point.value < THREAD_CONTENTS_WRITE_POINT) {
        throw Exception('活動ポイントが足りません\n支援ページでポイントを獲得してください');
      }

      if (_textController.text.isEmpty) {
        return;
      }

      log('message length: ${_textController.text.length}');

      if (_textController.text.length > 200) {
        throw Exception(
            'メッセージの長さ：${_textController.text.length}\nメッセージは200文字以内で入力してください。');
      }

      await _threadContentsService.createItem(
        threadId: Get.arguments.id,
        nickname: userInfoProvider.nickname.value,
        contents: _textController.text,
      );

      // 유저의 포인터 차감
      userInfoProvider.point.value =
          userInfoProvider.point.value - THREAD_CONTENTS_WRITE_POINT;
      await _usersService.updateUserPoint(
        userInfoProvider.point.value,
      );

      Get.focusScope?.unfocus();
      _textController.clear();

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      }

      CustomSnackbar.showSuccessSnackbar(
          title: 'Success', message: 'メッセージを送信しました。');
    } catch (error) {
      CustomSnackbar.showErrorSnackbar(title: 'Error', error: error);
      log('error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MessageSendFormWidget(
      textController: _textController,
      onSendMessage: _onSendMessage,
    );
  }
}
