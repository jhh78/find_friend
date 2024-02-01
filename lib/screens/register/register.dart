import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/register.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/backgroud_image.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/register/form_text_field.dart';
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
          title: Text(
            school.name.toString(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: COLOR_MAP['text'],
                ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              controller.seletedSchoolList.remove(school);
            },
          ),
        );
      }).toList(),
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
                title: Text(
                  REGISTER_TITLE,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: COLOR_MAP['text'],
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
                          Obx(
                            () => RegisterFormText(
                              title: REGISTER_NICKNAME_TITLE,
                              hintText: REGISTER_NICKNAME_HINT,
                              errorText: controller.nicknameError.value,
                              callBack: (value) {
                                controller.setNickname(value);
                              },
                            ),
                          ),
                          Obx(
                            () => RegisterFormText(
                              title: REGISTER_EMAIL_TITLE,
                              hintText: REGISTER_EMAIL_HINT,
                              errorText: controller.emailError.value,
                              callBack: (value) {
                                controller.setEmail(value);
                              },
                            ),
                          ),
                          const SchoolSearchField(),
                          if (controller.seletedSchoolList.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: CustomErrorWidget(
                                  errorText: SCHOOL_SEARCH_ERROR),
                            ),
                          Obx(() => _renderSelectedSchoolList(context)),
                          OutlinedButton(
                            onPressed: () {
                              debugPrint('登録ボタンが押されました');

                              UsersService().createItem().then((value) {
                                debugPrint('==> $value');
                                // TODO ::: 분기 처리 하기
                                if (value['status'] == 200) {
                                  debugPrint('登録完了 ${value['id']}');
                                } else {
                                  debugPrint('登録失敗 $value ${value['data']}');
                                }
                              });

                              // if (!controller.isValidateSuccess()) {
                              //   return;
                              // }

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const RootScreen(),
                              //   ),
                              // );
                            },
                            child: Text(
                              REGISTER_BUTTON_TEXT,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
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
