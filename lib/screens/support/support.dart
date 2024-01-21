import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Support Screen',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: COLOR_MAP['text'],
                ),
          ),
          Text(
            '여기에 인앱결제를 넣는다',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: COLOR_MAP['text'],
                ),
          ),
        ],
      ),
    );
  }
}
