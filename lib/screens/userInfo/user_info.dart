import 'package:find_friend/widgets/common/text_title.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  TextTitle(text: 'ユーザー情報'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
