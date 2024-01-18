import 'package:find_friend/screens/index.dart';
import 'package:find_friend/widgets/layout.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
          body: Center(
            child: Text(
              'Register Screen',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint('RegisterScreen FAB tapped');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const IndexScreen(),
              ));
            },
            child: const Icon(Icons.save_as_outlined),
          )),
    );
  }
}
