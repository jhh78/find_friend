import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:flutter/material.dart';

class RegisterFormText extends StatelessWidget {
  final String title;
  final String hintText;
  final String errorText;
  final Function(String) callBack;

  const RegisterFormText({
    super.key,
    required this.title,
    required this.hintText,
    required this.callBack,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: COLOR_MAP['text'],
                ),
          ),
          const SizedBox(height: 5),
          TextField(
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: COLOR_MAP['text'],
                ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: COLOR_MAP['hint'],
                  ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
            onChanged: (value) {
              debugPrint('value : $value');
              callBack(value);
            },
          ),
          errorText.isNotEmpty
              ? CustomErrorWidget(errorText: errorText.toString())
              : Container(),
        ],
      ),
    );
  }
}
