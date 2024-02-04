import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;

  const CustomErrorWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: errorText,
          kind: 'error',
        ),
      ],
    );
  }
}
