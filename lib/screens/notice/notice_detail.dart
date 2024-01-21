import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notice Detail Screen',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: COLOR_MAP['text'],
            ),
      ),
    );
  }
}
