import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
      ),
      body: Center(
        child: Text(
          'Notice Detail Screen',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
