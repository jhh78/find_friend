import 'package:flutter/material.dart';

class RegisterLayout extends StatelessWidget {
  final Widget child;
  const RegisterLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: child,
          ),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}
