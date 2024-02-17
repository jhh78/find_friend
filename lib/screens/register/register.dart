import 'dart:developer';

import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/common/textField.dart';
import 'package:find_friend/widgets/schools/schoolSearchedItems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final UserInfoProvider provider = Get.put(UserInfoProvider());

  final TextEditingController _nickNameController = TextEditingController();
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
          provider.doFormDataValidate(
            _nickNameController.text,
            _aboutMeController.text,
            provider.selectedSchoolList,
          );

          provider.setIsProcessing(true);

          RecordModel response = await _userService.createItem(
            _nickNameController.text,
            provider.selectedSchoolList,
            _aboutMeController.text,
          );

          log('response: $response');

          // 등록된 값으로 초기화
          provider.initValue(response);
          await _systemService.createItem('key', response.id);

          Get.to(() => RootScreen());
        } catch (error) {
          log('error : $error, ${error.toString()}');
          CustomSnackbar.showErrorSnackbar(title: '登録失敗', error: error);
        } finally {
          provider.setIsProcessing(false);
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
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFieldWidget(
                      isRequired: true,
                      controller: _nickNameController,
                      title: REGISTER_NICKNAME_TITLE,
                      hintText: REGISTER_NICKNAME_HINT,
                      errorText: provider.validate['nickName'],
                    ),
                    CustomTextAreaWidget(
                      isRequired: true,
                      controller: _aboutMeController,
                      title: REGISTER_ABOUT_ME_TITLE,
                      errorText: provider.validate['aboutMe'],
                    ),
                    SchoolSearchedItemsWidget(
                      isRequired: true,
                    ),
                    _renderRegisterButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
