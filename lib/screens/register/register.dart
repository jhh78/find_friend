import 'dart:developer';

import 'package:find_friend/providers/register.dart';
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
  final RegisterProvider _registerProvider = Get.put(RegisterProvider());

  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _depictionController = TextEditingController();

  final UsersService _userService = UsersService();
  final SystemService _systemService = SystemService();

  Widget _renderRegisterButton(BuildContext context) {
    if (_registerProvider.isProcessing.value) {
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
      onPressed: _doRegister,
      child: const CustomTextWidget(
        text: REGISTER_BUTTON_TEXT,
        kind: 'inputFieldTitle',
      ),
    );
  }

  void _doRegister() async {
    try {
      _registerProvider.isProcessing.value = true;

      if (_nickNameController.text.isEmpty) {
        throw Exception(REGISTER_NICKNAME_ERROR);
      }

      if (_depictionController.text.isEmpty) {
        throw Exception(REGISTER_ABOUT_ME_ERROR);
      }
      if (_registerProvider.selectedSchools.isEmpty) {
        throw Exception(SCHOOL_SEARCH_ERROR);
      }

      RecordModel response = await _userService.createItem(
        _nickNameController.text,
        _registerProvider.selectedSchools,
        _depictionController.text,
      );

      log('response: $response');

      // 등록된 값으로 초기화
      await _systemService.createItem('key', response.id);

      Get.to(() => RootScreen());
    } catch (error) {
      log('error : $error, ${error.toString()}');
      CustomSnackbar.showErrorSnackbar(title: '登録失敗', error: error);
    } finally {
      _registerProvider.isProcessing.value = false;
    }
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFieldWidget(
                  isRequired: true,
                  controller: _nickNameController,
                  title: REGISTER_NICKNAME_TITLE,
                  hintText: REGISTER_NICKNAME_HINT,
                ),
                CustomTextAreaWidget(
                  isRequired: true,
                  controller: _depictionController,
                  title: REGISTER_ABOUT_ME_TITLE,
                ),
                SchoolSearchedItemsWidget(
                  isRequired: true,
                ),
                _renderRegisterButton(context),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
