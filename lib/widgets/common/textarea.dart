import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomTextAreaWidget extends StatelessWidget {
  final String title;
  final Function(String) onChanged;
  final String errorText;
  final TextEditingController? controller;

  const CustomTextAreaWidget({
    super.key,
    required this.title,
    required this.onChanged,
    required this.errorText,
    this.controller,
  });

  InputDecoration _getInputDecoration(BuildContext context) {
    if (errorText.isNotEmpty) {
      return InputDecoration(
        hintText: title,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: COLOR_MAP['hint'],
            ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.red,
            ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2.0),
          ),
        ),
      );
    }

    return const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent,
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: title,
            kind: 'inputFieldTitle',
          ),
          TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: null,
            minLines: 5,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: COLOR_MAP['text'],
                ),
            decoration: _getInputDecoration(context),
          ),
        ],
      ),
    );
  }
}
