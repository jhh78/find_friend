import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/schools/schoolSearchedItems.dart';
import 'package:find_friend/widgets/userinfo/textItemDisplayArea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';

class UserInfoScreen extends StatelessWidget {
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final NumberFormat numberFormat = NumberFormat("###,###", "en_US");

  final UsersService _userService = UsersService();
  final TextEditingController _aboutMeController = TextEditingController();

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
          newMethod(context),
        ],
      ),
    );
  }

  Scaffold newMethod(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const CustomTextWidget(
          text: '基本情報',
          kind: 'headTitle',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            _aboutMeController.text = userInfoProvider.aboutMe.value;
            return Column(
              children: [
                UserInfoTextItemDisplayArea(
                  title: 'ニックネーム',
                  body: userInfoProvider.nickName.value,
                ),
                UserInfoTextItemDisplayArea(
                  title: 'Email',
                  body: userInfoProvider.email.value,
                ),
                SchoolSearchedItemsWidget(),
                UserInfoTextItemDisplayArea(
                  title: 'exp',
                  body: numberFormat.format(userInfoProvider.exp.value),
                ),
                UserInfoTextItemDisplayArea(
                  title: 'ポイント',
                  body: numberFormat.format(userInfoProvider.point.value),
                ),
                CustomTextAreaWidget(
                  controller: _aboutMeController,
                  title: REGISTER_ABOUT_ME_TITLE,
                  errorText: userInfoProvider.validate['aboutMe'],
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        onPressed: () async {
          try {
            userInfoProvider.setAboutMe(_aboutMeController.text);

            userInfoProvider.doFormDataValidate(
              userInfoProvider.nickName.value,
              userInfoProvider.email.value,
              _aboutMeController.text,
              userInfoProvider.selectedSchoolList,
            );

            if (userInfoProvider.selectedSchoolList.isEmpty) {
              throw Exception('学校情報がありません');
            }

            if (userInfoProvider.validate.isNotEmpty) {
              throw Exception('入力内容に不備があります');
            }

            userInfoProvider.setIsProcessing(true);

            // update
            await _userService.updateItem(
              userInfoProvider.nickName.value,
              userInfoProvider.email.value,
              userInfoProvider.selectedSchoolList,
              _aboutMeController.text,
            );

            CustomSnackbar.showSuccessSnackbar(
                title: '更新完了', message: '情報が更新されました');
          } on ClientException catch (error) {
            CustomSnackbar.showClientErrorSnackbar(title: '更新失敗', error: error);
          } catch (error) {
            CustomSnackbar.showDefaultErrorSnackbar(
                title: '更新失敗', error: error);
          } finally {
            userInfoProvider.setIsProcessing(false);
          }
        },
        child: const Icon(
          Icons.save_as_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
