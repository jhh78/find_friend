import 'package:find_friend/widgets/layout.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        body: Center(
          child: Text(
            'Index Screen',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}
