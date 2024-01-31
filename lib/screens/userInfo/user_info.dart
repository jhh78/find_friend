import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/widgets/common/text_title.dart';
import 'package:find_friend/widgets/userinfo/text_area.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("###,###", "en_US");
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const CustomTextTitleWidget(
          text: '基本情報',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UserInfoTextArea(title: 'ニックネーム', body: 'あいうえお'),
            const UserInfoTextArea(title: 'Email', body: 'aaa@aaa.com'),
            const UserInfoTextArea(title: '卒業学校', body: 'あああ高校'),
            UserInfoTextArea(title: 'EXP', body: f.format(9999999)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'あなたを説明する',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: COLOR_MAP['text'],
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (text) {
                      debugPrint('あなたを説明する: $text');
                    },
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: COLOR_MAP['text'],
                        ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('保存 click');
        },
        child: const Icon(
          Icons.save_as_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
