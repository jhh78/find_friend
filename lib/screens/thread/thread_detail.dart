import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class ThreadDetailScreen extends StatelessWidget {
  const ThreadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Thread Detail Screen',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: COLOR_MAP['text'],
            ),
      ),
    );
  }
}
