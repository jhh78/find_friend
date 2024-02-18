import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/threadContents.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/thread.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/thread/contsnts/contentsList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadContentsScreen extends StatelessWidget {
  ThreadContentsScreen({super.key});

  final ThreadContentsService threadContentsService = ThreadContentsService();
  final ThreadService threadService = ThreadService();

  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final ThreadContentsProvider threadContentsProvider =
      Get.put(ThreadContentsProvider());

  final List<String> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    log('ThreadDetailScreen build ${Get.arguments.id}');

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        log('scrollController called ${_scrollController.position.pixels} ${_scrollController.position.maxScrollExtent}');
        final int nextPage = threadContentsProvider.currentPage.value + 1;

        List<ThreadContentsTable> response = await threadContentsService
            .getContentsList(Get.arguments.id, nextPage);

        if (response.isNotEmpty) {
          log('scrollController response next page $nextPage ${response.length}');
          threadContentsProvider.currentPage.value = nextPage;
          threadContentsProvider.threadContentsList.addAll(response);
        }
      }
    });

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
            actions: [
              _renderRemoveThreadButton(Get.arguments.id),
              IconButton(
                onPressed: () {
                  log('add favorite');
                },
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                color: Colors.redAccent,
                onPressed: () {
                  log('remove favorite');
                },
                icon: const Icon(Icons.favorite_sharp),
              ),
            ],
          ),
          body: ThreadContentsListWidget(
            scrollController: _scrollController,
          ),
        )
      ],
    );
  }

  Widget _renderRemoveThreadButton(String threadId) {
    // if (Get.arguments.userId != userInfoProvider.userId.value) {
    //   return Container();
    // }
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
                              Get.offAll(
                                () => RootScreen(),
                                transition: Transition.size,
                                duration: const Duration(milliseconds: 500),
                              );
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
      icon: const Icon(Icons.remove_circle_outline),
    );
  }
}
