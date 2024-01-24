import 'package:find_friend/screens/root.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/register/form_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg1.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(REGISTER_TITLE,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: COLOR_MAP['text'],
                                  fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const RegisterFormText(
                            title: REGISTER_GRADUATED_SCHOOL_TITLE,
                            hintText: REGISTER_GRADUATED_SCHOOL_HINT,
                            errorText: REGISTER_GRADUATED_SCHOOL_ERROR,
                          ),
                          const RegisterFormText(
                            title: REGISTER_NICKNAME_TITLE,
                            hintText: REGISTER_NICKNAME_HINT,
                            errorText: REGISTER_NICKNAME_ERROR,
                          ),
                          const RegisterFormText(
                            title: REGISTER_EMAIL_TITLE,
                            hintText: REGISTER_EMAIL_HINT,
                            errorText: REGISTER_EMAIL_ERROR,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              debugPrint('登録ボタンが押されました');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RootScreen()),
                              );
                            },
                            child: Text(
                              REGISTER_BUTTON_TEXT,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: COLOR_MAP['text']),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
