import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/register.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/exceptions/client_exception.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/backgroud_image.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textarea.dart';
import 'package:find_friend/widgets/common/textfield.dart';
import 'package:find_friend/widgets/register/school_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  Widget _renderSelectedSchoolList(BuildContext context) {
    debugPrint('学校リストが選択されました ${controller.seletedSchoolList}');

    if (controller.seletedSchoolList.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: controller.seletedSchoolList.map((SchoolsTable school) {
        debugPrint('学校名: ${school.name}');
        return ListTile(
          title: CustomTextWidget(
            text: school.name.toString(),
            kind: 'titleMedium',
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.redAccent,
              size: 30,
            ),
            onPressed: () {
              controller.seletedSchoolList.remove(school);
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _renderRegisterButton(BuildContext context) {
    if (controller.isProcessing.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return OutlinedButton(
      onPressed: () async {
        debugPrint('登録ボタンが押されました');

        if (!controller.isValidateSuccess()) {
          return;
        }

        try {
          String result = await UsersService().createItem(
            controller.nickname.value,
            controller.email.value,
            controller.seletedSchoolList,
            controller.aboutMe.value,
          );
          await SystemService().createItem('key', result);
          Get.to(const RootScreen());
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
    Get.put(RegisterController());
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
                              errorText: controller.nicknameError.value,
                              callBack: controller.setNickname,
                            ),
                            CustomTextFieldWidget(
                              title: REGISTER_EMAIL_TITLE,
                              hintText: REGISTER_EMAIL_HINT,
                              errorText: controller.emailError.value,
                              callBack: controller.setEmail,
                            ),
                            CustomTextAreaWidget(
                              title: REGISTER_ABOUT_ME_TITLE,
                              errorText: controller.aboutMeError.value,
                              onChanged: controller.setAboutMe,
                            ),
                            const SchoolSearchField(),
                            if (!controller.isRegisterFormSchoolValidate.value)
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: CustomErrorWidget(
                                  errorText: SCHOOL_SEARCH_ERROR,
                                ),
                              ),
                            _renderSelectedSchoolList(context),
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
