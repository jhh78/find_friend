import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;

  const CustomErrorWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          errorText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.red,
              ),
        ),
      ],
    );
  }
}
