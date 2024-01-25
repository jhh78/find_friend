import 'package:find_friend/screens/notice/notice_detail.dart';
import 'package:find_friend/widgets/common/text_title.dart';
import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const TextTitle(
          text: 'お知らせ',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: List.generate(
          20,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoticeDetailScreen(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Text('$index'),
            ),
          ),
        ),
      ),
    );
  }
}
