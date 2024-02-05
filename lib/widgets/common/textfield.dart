import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final String errorText;
  final Function(String) callBack;
  final bool readOnly;

  const CustomTextFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.callBack,
    required this.errorText,
    this.readOnly = false,
  });

  InputDecoration _getInputDecoration(BuildContext context) {
    if (errorText.isNotEmpty) {
      return InputDecoration(
        hintText: hintText,
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

    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: COLOR_MAP['hint'],
          ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
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
            readOnly: readOnly,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: COLOR_MAP['text'],
                ),
            decoration: _getInputDecoration(context),
            onChanged: (value) {
              debugPrint('value : $value');
              callBack(value);
            },
          ),
        ],
      ),
    );
  }
}
