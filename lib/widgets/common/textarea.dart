import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomTextAreaWidget extends StatelessWidget {
  final String title;
  final String? errorText;
  final TextEditingController? controller;
  final bool isRequired;

  const CustomTextAreaWidget({
    super.key,
    required this.title,
    this.errorText,
    this.controller,
    this.isRequired = false,
  });

  Widget _renderTextTitle(BuildContext context) {
    if (isRequired) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: title,
            kind: 'inputFieldTitle',
          ),
          const CustomTextWidget(
            text: ' *必須',
            kind: 'error',
          ),
        ],
      );
    }

    return CustomTextWidget(
      text: title,
      kind: 'inputFieldTitle',
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    if (errorText != null) {
      return InputDecoration(
        hintText: title,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.grey,
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
          _renderTextTitle(context),
          TextFormField(
            controller: controller,
            maxLines: null,
            minLines: 5,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                ),
            decoration: _getInputDecoration(context),
          ),
        ],
      ),
    );
  }
}
