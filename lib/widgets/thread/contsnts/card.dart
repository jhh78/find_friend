import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/utils.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadItemCardWidget extends StatelessWidget {
  final bool isOwner;
  final ThreadContentsTable item;

  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  final ThreadContentsService _threadContentsService = ThreadContentsService();
  final UsersService _usersService = UsersService();

  ThreadItemCardWidget({super.key, required this.isOwner, required this.item});

  Widget _renderIconGroup() {
    Widget deleteButton() => SizedBox(
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
                                  text: 'close',
                                  kind: 'label',
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    await _threadContentsService.deleteItem(item.id.toString());
                                  } catch (error) {
                                    CustomSnackbar.showErrorSnackbar(title: 'Error', error: error);
                                    log('error: $error');
                                  } finally {
                                    Get.back();
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
            },
          ),
        );

    Widget messageButton() => SizedBox(
          width: 35,
          height: 35,
          child: IconButton(
            color: Colors.blue,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              final TextEditingController messageController = TextEditingController();

              if (userInfoProvider.point < THREAD_CONTENTS_PRIVATE_MESSAGE_POINT) {
                CustomSnackbar.showErrorSnackbar(
                  title: '活動ポイントが足りません',
                  error: Exception('支援ページでポイントを獲得してください'),
                );
                return;
              }

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

                                      await _threadContentsService.sendMessage(
                                        userInfoProvider.id.value,
                                        item.userId.toString(),
                                        messageController.text,
                                        item.contents.toString(),
                                      );

                                      // 유저의 포인터 차감
                                      userInfoProvider.point.value = userInfoProvider.point.value - THREAD_CONTENTS_PRIVATE_MESSAGE_POINT;
                                      userInfoProvider.exp.value = userInfoProvider.exp.value + ACTIVITY_EXP;
                                      await _usersService.updateUserPoint(
                                        userInfoProvider.point.value,
                                        userInfoProvider.exp.value,
                                      );

                                      Get.back();
                                      CustomSnackbar.showSuccessSnackbar(
                                        title: 'Success',
                                        message: 'メッセージを送信しました',
                                      );
                                    } catch (error) {
                                      log('error: $error');
                                      CustomSnackbar.showErrorSnackbar(title: 'Error', error: error);
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
                                    text: 'close',
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
            },
            icon: const Icon(
              Icons.mail_outlined,
            ),
          ),
        );
    return isOwner ? deleteButton() : messageButton();
  }

  @override
  Widget build(BuildContext context) {
    log('item.threadId: ${item.threadId}');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@${item.nickname.toString()}',
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextWidget(
              text: item.contents.toString(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                text: getDateFormatString(item.created.toString()),
              ),
              _renderIconGroup(),
            ],
          ),
        ],
      ),
    );
  }
}
