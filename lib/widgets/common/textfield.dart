import 'package:find_friend/providers/register.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFieldWidget extends GetView<RegisterController> {
  final String title;
  final String hintText;
  final String errorText;
  final Function(String) callBack;

  const CustomTextFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.callBack,
    required this.errorText,
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
    Get.put(RegisterController());
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
            readOnly: controller.isProcessing.value,
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
