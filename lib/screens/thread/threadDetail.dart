import 'dart:developer' as dev;
import 'dart:math';

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

  final List<String> messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    dev.log('ThreadDetailScreen build ${Get.arguments.title}');
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
          body: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10.0),
                  reverse: true,
                  itemCount: 40,
                  itemBuilder: (_, int index) =>
                      _renderMessageItem(context, 'messages[index] $index'),
                ),
              ),
              const Divider(height: 1.0),
              _buildTextComposer(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _renderMessageItem(BuildContext context, String message) {
    var intValue = Random().nextInt(10);

    if (intValue.isEven) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment:
              intValue.isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            const CircleAvatar(
              child: Text('A'),
            ),
            const SizedBox(
              width: 3,
            ),
            Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            intValue.isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Card(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          const CircleAvatar(
            child: Text('B'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              maxLines: 3,
              minLines: 1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
              keyboardType: TextInputType.multiline,
              controller: _textController,
              onSubmitted: (value) {
                dev.log('onSubmitted: $value');
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
              onPressed: () {
                dev.log(_textController.text);
                _textController.clear();
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
