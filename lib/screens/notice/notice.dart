import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Center(
            child: Text(
      'Notice Screen',
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: COLOR_MAP['text'],
          ),
    )));
  }
}
