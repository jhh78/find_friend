import 'dart:developer';

import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/widgets/common/messageSendForm.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadContentsMessageFormWidget extends StatelessWidget {
  final ScrollController scrollController;

  final ThreadContentsService _threadContentsService = ThreadContentsService();
  final TextEditingController _textController = TextEditingController();

  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  ThreadContentsMessageFormWidget({super.key, required this.scrollController});

  void _onSendMessage() async {
    try {
      if (_textController.text.isEmpty) {
        return;
      }

      log('message length: ${_textController.text.length}');

      // if (_textController.text.length > 200) {
      //   throw Exception(
      //       'メッセージの長さ：${_textController.text.length}\nメッセージは200文字以内で入力してください。');
      // }

      // await _threadContentsService.createItem(
      //   threadId: Get.arguments.id,
      //   nickname: userInfoProvider.nickName.toString(),
      //   contents: _textController.text,
      // );

      // Get.focusScope?.unfocus();
      // _textController.clear();

      // if (scrollController.hasClients) {
      //   scrollController.animateTo(
      //     scrollController.position.minScrollExtent,
      //     duration: const Duration(seconds: 1),
      //     curve: Curves.fastLinearToSlowEaseIn,
      //   );
      // }

      // CustomSnackbar.showSuccessSnackbar(
      //     title: 'Success', message: 'メッセージを送信しました。');
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
