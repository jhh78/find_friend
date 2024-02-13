import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/threadContents.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadDetailScreen extends StatelessWidget {
  ThreadDetailScreen({super.key});

  final ThreadContentsService threadContentsService = ThreadContentsService();
  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final ThreadContentsProvider threadContentsProvider =
      Get.put(ThreadContentsProvider());

  final List<String> messages = [];
  final TextEditingController _textController = TextEditingController();
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
            body: _renderThreadContents(context))
      ],
    );
  }

  Widget _renderThreadContents(BuildContext context) {
    Widget renderMessageList(BuildContext context) => ListView.builder(
          itemCount: threadContentsProvider.threadContentsList.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            ThreadContentsTable item =
                threadContentsProvider.threadContentsList[index];

            return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                color: Colors.white,
                child: newMethod22(item, context));
          },
        );

    Widget renderNoMessage() => const Center(
          child: CustomTextWidget(
            text: 'スレットがありません。',
            kind: 'label',
          ),
        );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Obx(
            () => threadContentsProvider.threadContentsList.isEmpty
                ? renderNoMessage()
                : renderMessageList(context),
          ),
        ),
        const Divider(height: 1.0),
        _renderInputForm(context),
      ],
    );
  }

  Widget newMethod22(ThreadContentsTable item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (item.userId == userInfoProvider.userId.value)
                IconButton(
                  color: Colors.red,
                  onPressed: () {
                    Get.dialog(Center(
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
                                        await threadContentsService
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
                    ));
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderInputForm(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              cursorColor: Colors.black,
              maxLines: 3,
              minLines: 1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
              keyboardType: TextInputType.multiline,
              controller: _textController,
              onSubmitted: (value) {
                log('onSubmitted: $value');
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Send a message',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              color: Colors.blue,
              onPressed: () async {
                try {
                  log(_textController.text);
                  await threadContentsService.createItem(
                    threadId: Get.arguments.id,
                    nickname: userInfoProvider.nickName.toString(),
                    contents: _textController.text,
                  );
                  _textController.clear();
                  _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                } catch (error) {
                  CustomSnackbar.showDefaultErrorSnackbar(
                      title: 'Error', error: error);
                  log('error: $error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
