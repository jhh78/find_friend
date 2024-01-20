import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class ThreadScreen extends StatelessWidget {
  const ThreadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Center(
      child: Text('Thread Screen',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: COLOR_MAP['text'],
              )),
    ));
  }
}
