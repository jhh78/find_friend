import 'package:find_friend/providers/userDefualtInfo.dart';
import 'package:find_friend/screens/register/schoolSearch.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/register/selectedSchoolList.dart';
import 'package:find_friend/widgets/userinfo/textArea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  UserInfoScreen createState() => UserInfoScreen();
}

class UserInfoScreen extends State<UserInfo> {
  final UserDefaultInfoController defaultUserController =
      Get.put(UserDefaultInfoController());

  @override
  void initState() {
    super.initState();
    defaultUserController.getUserInfoData();
  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("###,###", "en_US");
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
          () => Column(
            children: [
              UserInfoTextArea(
                title: 'ニックネーム',
                body: defaultUserController.nickname.value,
              ),
              UserInfoTextArea(
                title: 'Email',
                body: defaultUserController.email.value,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '卒業した学校',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_box_outlined,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            Get.to(() => SchoolSearchScreen());
                          },
                        )
                      ],
                    ),
                    SelectedSchoolListWidget(
                      list: defaultUserController.seletedSchoolList,
                    ),
                  ],
                ),
              ),
              UserInfoTextArea(
                title: 'exp',
                body: f.format(defaultUserController.exp.value),
              ),
              UserInfoTextArea(
                title: 'ポイント',
                body: f.format(defaultUserController.point.value),
              ),
              CustomTextAreaWidget(
                title: REGISTER_ABOUT_ME_TITLE,
                errorText: defaultUserController.aboutMe.value.isEmpty
                    ? REGISTER_ABOUT_ME_ERROR
                    : '',
                controller: TextEditingController(
                  text: defaultUserController.aboutMe.value,
                ),
                onChanged: defaultUserController.setAboutMe,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('保存 click');
        },
        child: const Icon(
          Icons.save_as_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
