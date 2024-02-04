import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textarea.dart';
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
        title: const CustomTextWidget(
          text: '基本情報',
          kind: 'headTitle',
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
            CustomTextAreaWidget(
              title: REGISTER_ABOUT_ME_TITLE,
              errorText: REGISTER_ABOUT_ME_ERROR,
              onChanged: (value) {
                debugPrint('自己紹介: $value');
              },
            )
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
