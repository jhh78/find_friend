import 'package:find_friend/screens/register/register.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('IntroScreen tapped');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      },
      child: Stack(
        children: [
          Image.asset(
            'assets/images/intro.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }
}
