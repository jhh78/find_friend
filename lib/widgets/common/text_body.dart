import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextBodyWidget extends StatelessWidget {
  final String text;
  const CustomTextBodyWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: COLOR_MAP['text'],
            ),
      ),
    );
  }
}
