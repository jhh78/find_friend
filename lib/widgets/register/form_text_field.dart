import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class RegisterFormText extends StatelessWidget {
  final String title;
  final String hintText;
  final String? errorText;

  const RegisterFormText({
    Key? key,
    required this.title,
    required this.hintText,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: COLOR_MAP['text'])),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 20, color: COLOR_MAP['hint']),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )),
          ),
          errorText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    errorText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: COLOR_MAP['error']),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
