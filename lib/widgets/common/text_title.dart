import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextTitleWidget extends StatelessWidget {
  final String text;
  const CustomTextTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: COLOR_MAP['text'],
            ),
      ),
    );
  }
}
