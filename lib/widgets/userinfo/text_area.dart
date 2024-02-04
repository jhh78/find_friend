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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: title,
                kind: 'inputFieldTitle',
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: CustomTextWidget(
                  text: body,
                  kind: 'body',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
