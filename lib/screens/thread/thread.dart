import 'package:find_friend/screens/thread/thread_detail.dart';
import 'package:flutter/material.dart';

class ThreadScreen extends StatelessWidget {
  const ThreadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThreadDetailScreen(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Text('$index'),
            ),
          ),
        ),
      ),
    );
  }
}
