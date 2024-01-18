import 'package:find_friend/screens/index.dart';
import 'package:find_friend/widgets/layout.dart';
import 'package:find_friend/widgets/register/form_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('新規ユーザ登録',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ),
                    const RegisterFormText(
                      title: '卒業した学校名',
                      hintText: '学校名を入力してください',
                      errorText: '学校名を入力してください',
                    ),
                    const RegisterFormText(
                      isDropdown: true,
                      title: '卒業年',
                      hintText: '卒業年を選択してください',
                      errorText: '卒業年を選択してください',
                    ),
                    const RegisterFormText(
                      title: 'ニックネーム',
                      hintText: 'ニックネームを入力してください',
                      errorText: 'ニックネームを入力してください',
                    ),
                    OutlinedButton(
                      onPressed: () {
                        debugPrint('登録ボタンが押されました');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndexScreen()),
                        );
                      },
                      child: const Text(
                        '登録',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
