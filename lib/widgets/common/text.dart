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
              color: Colors.black,
            ),
      );
    } else if (kind == 'inputFieldTitle' || kind == 'label') {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black,
            ),
      );
    } else if (kind == 'body') {
      return Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,
            ),
      );
    } else if (kind == 'error') {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.red,
            ),
      );
    } else if (kind == 'button') {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black,
            ),
      );
    }

    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _renderTextWidget(context);
  }
}
