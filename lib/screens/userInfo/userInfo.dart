import 'dart:developer';

import 'package:find_friend/models/user.dart';
import 'package:find_friend/providers/register.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/utils/utils.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/schools/schoolSearchedItems.dart';
import 'package:find_friend/widgets/userinfo/textItemDisplayArea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends StatelessWidget {
  final RegisterProvider registerProvider = Get.put(RegisterProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  final UsersService _userService = UsersService();
  final TextEditingController _depictionController = TextEditingController();

  UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          const CustomBackGroundImageWidget(
            type: 'bg',
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: const CustomTextWidget(
                text: '基本情報',
                kind: 'headTitle',
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Obx(
                () => !userInfoProvider.isReady.value
                    ? const CircularProgressIndicator()
                    : _renderContentsLayout(userInfoProvider.userInfo.value),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: _saveButtonOnClick,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.save_as_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _renderContentsLayout(UsersTable userInfo) {
    log('userInfo: ${userInfo.toMap()}', name: 'UserInfoScreen');
    registerProvider.selectedSchools.value = userInfo.schools ?? [];
    _depictionController.text = userInfo.depiction ?? '';
    return Column(
      children: [
        UserInfoTextItemDisplayArea(
          title: 'ニックネーム',
          body: userInfo.nickname ?? '',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SchoolSearchedItemsWidget(),
        ),
        UserInfoTextItemDisplayArea(
          title: 'exp',
          body: getNumberFotmatString(userInfo.exp ?? 0),
        ),
        UserInfoTextItemDisplayArea(
          title: 'ポイント',
          body: getNumberFotmatString(userInfo.point ?? 0),
        ),
        CustomTextAreaWidget(
          isRequired: true,
          controller: _depictionController,
          title: REGISTER_ABOUT_ME_TITLE,
        )
      ],
    );
  }

  Future<void> _saveButtonOnClick() async {
    try {
      userInfoProvider.isProcessing(true);

      if (registerProvider.selectedSchools.isEmpty) {
        throw Exception(SCHOOL_SEARCH_ERROR);
      }

      if (_depictionController.text.isEmpty) {
        throw Exception(REGISTER_ABOUT_ME_ERROR);
      }

      // update
      await _userService.updateItem(
        userInfoProvider,
        _depictionController.text,
      );

      CustomSnackbar.showSuccessSnackbar(title: '更新完了', message: '情報が更新されました');
    } catch (error) {
      log('error: $error', name: 'UserInfoScreen');
      CustomSnackbar.showErrorSnackbar(title: '更新失敗', error: error);
    } finally {
      userInfoProvider.isProcessing(false);
      Get.focusScope?.unfocus();
    }
  }
}
