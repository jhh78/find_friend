import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final String? kind;

  const CustomTextWidget({super.key, required this.text, this.kind});

  Widget _renderTextWidget(BuildContext context) {
    if (kind == 'headTitle') {
      return Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: COLOR_MAP['text'],
            ),
      );
    } else if (kind == 'inputFieldTitle' || kind == 'label') {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: COLOR_MAP['text'],
            ),
      );
    } else if (kind == 'body') {
      return Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: COLOR_MAP['text'],
            ),
      );
    } else if (kind == 'error') {
      return Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
      );
    } else if (kind == 'button') {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black54,
            ),
      );
    }

    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.black87,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _renderTextWidget(context),
    );
  }
}
