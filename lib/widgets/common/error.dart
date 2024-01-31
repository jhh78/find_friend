import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;

  const CustomErrorWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            errorText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
      ],
    );
  }
}
