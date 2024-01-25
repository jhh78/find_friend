import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class UserInfoTextArea extends StatelessWidget {
  final String title;
  final String body;
  const UserInfoTextArea({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: COLOR_MAP['text'],
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  body,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: COLOR_MAP['text'],
                      ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
