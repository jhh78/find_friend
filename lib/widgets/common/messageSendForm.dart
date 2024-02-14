import 'package:flutter/material.dart';

class MessageSendFormWidget extends StatelessWidget {
  final TextEditingController textController;
  final Function() onSendMessage;

  const MessageSendFormWidget(
      {super.key, required this.textController, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
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
              controller: textController,
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
              onPressed: onSendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
