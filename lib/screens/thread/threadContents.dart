import 'dart:developer';

import 'package:find_friend/providers/favorite.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/threadContents.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/thread.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/thread/contsnts/contentsList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadContentsScreen extends StatefulWidget {
  const ThreadContentsScreen({super.key});

  @override
  ThreadContentsScreenState createState() => ThreadContentsScreenState();
}

class ThreadContentsScreenState extends State<ThreadContentsScreen> {
  final ThreadContentsService threadContentsService = ThreadContentsService();
  final ThreadService threadService = ThreadService();

  final FavoriteProvider favoriteProvider = Get.put(FavoriteProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final ThreadContentsProvider threadContentsProvider =
      Get.put(ThreadContentsProvider());

  final List<String> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    log('ThreadContentsScreen initState ${Get.arguments.id}',
        name: 'ThreadContentsScreen');
    super.initState();
    threadContentsProvider.initThreadContentsList();
    threadContentsProvider.addSubscribedThreadContents();
  }

  @override
  void dispose() {
    log('ThreadContentsScreen dispose', name: 'ThreadContentsScreen');
    threadContentsProvider.removeSubscribedThreadContents();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('ThreadDetailScreen build ${Get.arguments.id}');

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        threadContentsProvider.getNextThreadContentsList();
      }
    });

    return PopScope(
      onPopInvoked: (didPop) => threadProvider.initThreadList(),
      child: Stack(
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
              actions: [
                _renderRemoveThreadButton(),
                Obx(
                  () => _renderFavoriteButton(),
                ),
              ],
            ),
            body: ThreadContentsListWidget(
              scrollController: _scrollController,
            ),
          )
        ],
      ),
    );
  }

  Widget _renderFavoriteButton() {
    final String threadId = Get.arguments.id;
    log('renderFavoriteButton ${favoriteProvider.isFavoriteThread(threadId)}');
    if (favoriteProvider.isFavoriteThread(threadId)) {
      return IconButton(
        color: Colors.redAccent,
        onPressed: () async {
          try {
            await favoriteProvider.removeFavoriteThread(threadId);
          } catch (error) {
            CustomSnackbar.showErrorSnackbar(
              title: 'Error',
              error: error,
            );
          }
        },
        icon: const Icon(Icons.favorite_sharp),
      );
    }

    return IconButton(
      onPressed: () async {
        try {
          await favoriteProvider.addFavoriteThread(threadId);
        } catch (error) {
          CustomSnackbar.showErrorSnackbar(
            title: 'Error',
            error: error,
          );
        }
      },
      icon: const Icon(Icons.favorite_border),
    );
  }

  Widget _renderRemoveThreadButton() {
    final String userId = Get.arguments.userId;
    final String threadId = Get.arguments.id;
    if (userId != userInfoProvider.id.value) {
      return Container();
    }
    return IconButton(
      color: Colors.red,
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
                        text: 'Delete this thread?',
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
                              await threadService.deleteThread(threadId);
                              Get.back();
                              Get.back();
                            } catch (error) {
                              Get.back();
                              CustomSnackbar.showErrorSnackbar(
                                title: 'Error',
                                error: error,
                              );
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
      icon: const Icon(Icons.delete_forever),
    );
  }
}
