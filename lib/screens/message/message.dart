import 'dart:developer';

import 'package:find_friend/models/message.dart';
import 'package:find_friend/providers/message.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/message.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/utils.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final MessageProvider messageProvider = Get.put(MessageProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  final ScrollController _scrollController = ScrollController();
  final MessageService messageService = MessageService();
  final SystemService systemService = SystemService();

  @override
  void initState() {
    log('initState', name: 'MessageScreen');
    super.initState();
    messageProvider.initMassageList();
  }

  @override
  void dispose() {
    log('dispose', name: 'MessageScreen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final int nextPage = messageProvider.currentPage.value + 1;

        List<MessageTable> response = await messageService.getMessageList(
          userInfoProvider.id.value,
          nextPage,
          PAGE_PER_ITEM,
        );

        if (response.isNotEmpty) {
          messageProvider.currentPage.value = nextPage;
          messageProvider.messageList.addAll(response);
        }
      }
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const CustomTextWidget(
          text: 'メッセージ',
          kind: 'headTitle',
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => messageProvider.messageList.isEmpty
            ? const Center(
                child: Center(
                  child: CustomTextWidget(
                    text: 'メッセージがありません',
                    kind: 'label',
                  ),
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: messageProvider.messageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _renderMessageList(
                    context,
                    messageProvider.messageList[index],
                  );
                },
              ),
      ),
    );
  }

  Widget deleteButton(MessageTable message) {
    return SizedBox(
      width: 35,
      height: 35,
      child: IconButton(
        color: Colors.red,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: const Icon(
          Icons.remove_circle_outline,
        ),
        onPressed: () {
          _deleteMessageButtonOnClick(message);
        },
      ),
    );
  }

  void _deleteMessageButtonOnClick(MessageTable message) {
    Get.dialog(
      Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: CustomTextWidget(
                    text: 'Delete this message?',
                    kind: 'label',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const CustomTextWidget(
                        text: 'Cancel',
                        kind: 'label',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          await messageService.deleteMessage(message.id);
                          Get.back();

                          messageProvider.messageList.remove(message);
                          CustomSnackbar.showSuccessSnackbar(
                              title: 'Success', message: 'メッセージを削除しました');
                        } catch (error) {
                          Get.back();
                          CustomSnackbar.showErrorSnackbar(
                              title: 'Error', error: error);
                          log('error: $error');
                        }
                      },
                      child: const CustomTextWidget(
                        text: 'Delete',
                        kind: 'label',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget messageButton(MessageTable message) {
    return SizedBox(
      width: 35,
      height: 35,
      child: IconButton(
        color: Colors.blue,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          _sendMessageButtonOnClick(message);
        },
        icon: const Icon(
          Icons.mail_outline,
        ),
      ),
    );
  }

  void _sendMessageButtonOnClick(MessageTable message) {
    final TextEditingController messageController = TextEditingController();
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextWidget(
                        text: 'Send a message',
                        kind: 'label',
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            if (messageController.text.isEmpty) {
                              throw Exception('メッセージは必須です');
                            }

                            if (messageController.text.length > 200) {
                              throw Exception('メッセージは200文字以内で入力してください');
                            }

                            await messageService.sendMessage(
                              userInfoProvider.id.value,
                              message.fromUser.id.toString(),
                              messageController.text,
                              message.message,
                            );

                            await messageService.deleteMessage(message.id);
                            messageProvider.messageList.remove(message);

                            Get.back();
                            CustomSnackbar.showSuccessSnackbar(
                                title: 'Success', message: 'メッセージを送信しました');
                          } catch (error) {
                            Get.back();
                            CustomSnackbar.showErrorSnackbar(
                                title: 'Error', error: error);
                          }
                        },
                        icon: const Icon(
                          Icons.mail_outline_rounded,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  CustomTextAreaWidget(
                    isRequired: true,
                    title: 'メッセージを送信',
                    controller: messageController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const CustomTextWidget(
                          text: 'Cancel',
                          kind: 'label',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderMessageList(BuildContext context, MessageTable message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${message.fromUser.nickname}',
                softWrap: true,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextWidget(
                  text: message.oriMessage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextWidget(
                  text: message.message,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: getDateFormatString(message.created),
                  ),
                  Row(
                    children: [
                      deleteButton(message),
                      messageButton(message),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
