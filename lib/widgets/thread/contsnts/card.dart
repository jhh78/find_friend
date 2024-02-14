import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadItemCardWidget extends StatelessWidget {
  final bool isOwner;
  final ThreadContentsTable item;

  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  final ThreadContentsService _threadContentsService = ThreadContentsService();

  ThreadItemCardWidget({super.key, required this.isOwner, required this.item});

  Widget _renderDeleteIcon() {
    if (!isOwner) {
      return Container();
    }

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
                                await _threadContentsService
                                    .deleteItem(item.id.toString());
                                Get.back();
                              } catch (error) {
                                CustomSnackbar.showDefaultErrorSnackbar(
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
        },
      ),
    );
  }

  Widget _renderMessageButton() {
    if (isOwner) {
      return Container();
    }

    return SizedBox(
      width: 35,
      height: 35,
      child: IconButton(
        color: Colors.blue,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          log('userId: >>>> ${item.userId}');
        },
        icon: const Icon(
          Icons.message_outlined,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderDeleteIcon(),
              _renderMessageButton(),
            ],
          ),
        ],
      ),
    );
  }
}
