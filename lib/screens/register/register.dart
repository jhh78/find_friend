import 'package:find_friend/screens/root.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/backgroud_image.dart';
import 'package:find_friend/widgets/register/form_text_field.dart';
import 'package:find_friend/widgets/register/school_search_field.dart';
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
            const CustomBackGroundImageWidget(type: 'bg1'),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                centerTitle: true,
                toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                title: Text(
                  REGISTER_TITLE,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: COLOR_MAP['text'],
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                          const SchoolSearchField(),
                          OutlinedButton(
                            onPressed: () {
                              debugPrint('登録ボタンが押されました');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RootScreen(),
                                ),
                              );
                            },
                            child: Text(
                              REGISTER_BUTTON_TEXT,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: COLOR_MAP['text'],
                              ),
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
