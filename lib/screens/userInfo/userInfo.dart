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
import 'package:intl/intl.dart';

class UserInfoScreen extends StatelessWidget {
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

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
            // body: SingleChildScrollView(
            //   child: Obx(
            //     () => userInfoProvider.nickName.value.isEmpty
            //         ? const CircularProgressIndicator()
            //         : _renderContentsLayout(),
            //   ),
            // ),
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

  // Column _renderContentsLayout() {
  //   _aboutMeController.text = userInfoProvider.aboutMe.value;
  //   return Column(
  //     children: [
  //       UserInfoTextItemDisplayArea(
  //         title: 'ニックネーム',
  //         body: userInfoProvider.nickName.value,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 5),
  //         child: SchoolSearchedItemsWidget(),
  //       ),
  //       UserInfoTextItemDisplayArea(
  //         title: 'exp',
  //         body: getNumberFotmatString(userInfoProvider.exp.value),
  //       ),
  //       UserInfoTextItemDisplayArea(
  //         title: 'ポイント',
  //         body: getNumberFotmatString(userInfoProvider.point.value),
  //       ),
  //       CustomTextAreaWidget(
  //         isRequired: true,
  //         controller: _aboutMeController,
  //         title: REGISTER_ABOUT_ME_TITLE,
  //         errorText: userInfoProvider.validate['aboutMe'],
  //       )
  //     ],
  //   );
  // }

  Future<void> _saveButtonOnClick() async {
    try {
      // userInfoProvider.setAboutMe(_aboutMeController.text);

      // userInfoProvider.doFormDataValidate(
      //   userInfoProvider.nickName.value,
      //   _aboutMeController.text,
      //   userInfoProvider.selectedSchoolList,
      // );

      // userInfoProvider.setIsProcessing(true);

      // // update
      // await _userService.updateItem(
      //   userInfoProvider,
      //   _aboutMeController.text,
      // );

      // CustomSnackbar.showSuccessSnackbar(title: '更新完了', message: '情報が更新されました');
    } catch (error) {
      CustomSnackbar.showErrorSnackbar(title: '更新失敗', error: error);
    } finally {
      // userInfoProvider.setIsProcessing(false);
      // Get.focusScope?.unfocus();
    }
  }
}
