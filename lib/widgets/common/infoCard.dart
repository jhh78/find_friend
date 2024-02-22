import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomInfoCardWidget extends StatelessWidget {
  final String message;

  const CustomInfoCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextWidget(
            text: message,
            kind: 'info',
          ),
        ),
      ),
    );
  }
}
