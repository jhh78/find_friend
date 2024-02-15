import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomTextWidget(
        text: 'メッセージ',
        kind: 'headTitle',
      ),
    );
  }
}
