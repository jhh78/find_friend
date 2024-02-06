import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/schoolSearch/schoolSearch.dart';
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
import 'package:find_friend/widgets/schools/schoolSearchedItems.dart';
import 'package:find_friend/widgets/schools/selectedSchoolList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final UserInfoProvider provider = Get.put(UserInfoProvider());

  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  final UsersService _userService = UsersService();
  final SystemService _systemService = SystemService();

  Widget _renderRegisterButton(BuildContext context) {
    if (provider.isProcessing.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
      onPressed: () async {
        try {
          debugPrint('Register button pressed ${_nickNameController.text}');
          debugPrint('Register button pressed ${_emailController.text}');
          debugPrint('Register button pressed ${_aboutMeController.text}');

          provider.doFormDataValidate(
            _nickNameController.text,
            _emailController.text,
            _aboutMeController.text,
            provider.selectedSchoolList,
          );

          if (provider.validate.isNotEmpty) {
            return;
          }

          String uuid = await _userService.createItem(
            _nickNameController.text,
            _emailController.text,
            provider.selectedSchoolList,
            _aboutMeController.text,
          );
          await _systemService.createItem('key', uuid);
          Get.to(RootScreen());
        } catch (error) {
          Get.snackbar(
            '登録失敗',
            ClientExceptionController.getErrorMessage(error),
            colorText: Colors.white,
            backgroundColor: Colors.black,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(10),
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
      child: Stack(
        children: [
          const CustomBackGroundImageWidget(type: 'bg'),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: true,
              toolbarHeight: 50,
              title: const CustomTextWidget(
                text: REGISTER_TITLE,
                kind: 'headTitle',
              ),
            ),
            body: SingleChildScrollView(
              child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFieldWidget(
                        controller: _nickNameController,
                        title: REGISTER_NICKNAME_TITLE,
                        hintText: REGISTER_NICKNAME_HINT,
                        errorText: provider.validate['nickName'],
                      ),
                      CustomTextFieldWidget(
                        controller: _emailController,
                        title: REGISTER_EMAIL_TITLE,
                        hintText: REGISTER_EMAIL_HINT,
                        errorText: provider.validate['email'],
                      ),
                      CustomTextAreaWidget(
                        controller: _aboutMeController,
                        title: REGISTER_ABOUT_ME_TITLE,
                        errorText: provider.validate['aboutMe'],
                      ),
                      SchoolSearchedItemsWidget(
                        isProcessing: provider.isProcessing.value,
                        validate: provider.validate['schools'],
                        schools: provider.selectedSchoolList,
                      ),
                      _renderRegisterButton(context),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
