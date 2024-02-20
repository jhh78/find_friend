import 'dart:developer';

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
  final UserInfoProvider _userInfoProvider = Get.put(UserInfoProvider());

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
            body: Obx(() {
              if (_userInfoProvider.id.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _renderContentsLayout(),
                ),
              );
            }),
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

  Widget _renderContentsLayout() {
    _depictionController.text = _userInfoProvider.depiction.value;
    return Column(
      children: [
        UserInfoTextItemDisplayArea(
          title: 'ニックネーム',
          body: _userInfoProvider.nickname.value,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SchoolSearchedItemsWidget(),
        ),
        UserInfoTextItemDisplayArea(
          title: 'exp',
          body: getNumberFotmatString(_userInfoProvider.exp.value),
        ),
        UserInfoTextItemDisplayArea(
          title: 'ポイント',
          body: getNumberFotmatString(_userInfoProvider.point.value),
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
      _userInfoProvider.isProcessing(true);

      if (_userInfoProvider.schools.isEmpty) {
        throw Exception(SCHOOL_SEARCH_ERROR);
      }

      if (_depictionController.text.isEmpty) {
        throw Exception(REGISTER_ABOUT_ME_ERROR);
      }

      // update
      await _userService.updateIserDefaultInfo(
        _userInfoProvider.schools,
        _depictionController.text,
      );

      CustomSnackbar.showSuccessSnackbar(title: '更新完了', message: '情報が更新されました');
    } catch (error) {
      log('error: $error', name: 'UserInfoScreen');
      CustomSnackbar.showErrorSnackbar(title: '更新失敗', error: error);
    } finally {
      _userInfoProvider.isProcessing(false);
      Get.focusScope?.unfocus();
    }
  }
}
