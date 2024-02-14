import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final String? errorText;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final isRequired;

  const CustomTextFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    this.errorText,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.isRequired = false,
  });

  InputDecoration _getInputDecoration(BuildContext context) {
    if (errorText != null) {
      return InputDecoration(
        hintText: hintText,
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

    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.grey,
          ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
    );
  }

  Widget _renderTitleArea(BuildContext context) {
    if (isRequired) {
      return Row(
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderTitleArea(context),
          TextField(
            keyboardType: keyboardType ?? TextInputType.text,
            controller: controller,
            readOnly: readOnly,
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
