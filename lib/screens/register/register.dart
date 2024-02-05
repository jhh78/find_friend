import 'package:find_friend/providers/userDefualtInfo.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/exceptions/clientException.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/common/textField.dart';
import 'package:find_friend/widgets/register/schoolSearchButton.dart';
import 'package:find_friend/widgets/register/selectedSchoolList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final UserDefaultInfoController defaultUserController =
      Get.put(UserDefaultInfoController());

  Widget _renderRegisterButton(BuildContext context) {
    if (defaultUserController.isProcessing.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return OutlinedButton(
      onPressed: () async {
        if (!defaultUserController.isValidateSuccess()) {
          return;
        }

        try {
          String uuid = await UsersService().createItem(
            defaultUserController.nickname.value,
            defaultUserController.email.value,
            defaultUserController.seletedSchoolList,
            defaultUserController.aboutMe.value,
          );
          await SystemService().createItem('key', uuid);
          Get.to(RootScreen());
        } catch (error) {
          Get.snackbar(
            '登録失敗',
            ClientExceptionController.getErrorMessage(error),
            colorText: Colors.white,
            backgroundColor: Colors.black,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      child: const CustomTextWidget(
        text: REGISTER_BUTTON_TEXT,
        kind: 'inputFieldTitle',
      ),
    );
  }

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
                title: const CustomTextWidget(
                  text: REGISTER_TITLE,
                  kind: 'headTitle',
                ),
              ),
              body: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTextFieldWidget(
                              title: REGISTER_NICKNAME_TITLE,
                              hintText: REGISTER_NICKNAME_HINT,
                              errorText:
                                  defaultUserController.nicknameError.value,
                              callBack: defaultUserController.setNickname,
                            ),
                            CustomTextFieldWidget(
                              title: REGISTER_EMAIL_TITLE,
                              hintText: REGISTER_EMAIL_HINT,
                              errorText: defaultUserController.emailError.value,
                              callBack: defaultUserController.setEmail,
                            ),
                            CustomTextAreaWidget(
                              title: REGISTER_ABOUT_ME_TITLE,
                              errorText:
                                  defaultUserController.aboutMeError.value,
                              onChanged: defaultUserController.setAboutMe,
                            ),
                            SchoolSearchField(),
                            if (!defaultUserController
                                .isRegisterFormSchoolValidate.value)
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: CustomErrorWidget(
                                  errorText: SCHOOL_SEARCH_ERROR,
                                ),
                              ),
                            SelectedSchoolListWidget(
                              list: defaultUserController.seletedSchoolList,
                            ),
                            _renderRegisterButton(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
