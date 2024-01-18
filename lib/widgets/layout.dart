import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }
}
