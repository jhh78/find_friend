import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class UserInfoTextArea extends StatelessWidget {
  final String title;
  final String body;
  const UserInfoTextArea({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextWidget(
            text: title,
            kind: 'label',
          ),
          CustomTextWidget(
            text: body,
            kind: 'label',
          ),
        ],
      ),
    );
  }
}
