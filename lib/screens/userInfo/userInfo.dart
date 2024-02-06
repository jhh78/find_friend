import 'package:find_friend/models/schools.dart';
import 'package:find_friend/screens/schoolSearch/schoolSearch.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/schools/selectedSchoolList.dart';
import 'package:find_friend/widgets/userinfo/textItemDisplayArea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  UserInfoScreen createState() => UserInfoScreen();
}

class UserInfoScreen extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
  }

  final String _nickName = '';
  final String _email = '';
  final int _exp = 0;
  final int _point = 0;

  final List<SchoolsTable> _selectedSchoolList = [];
  final TextEditingController _aboutMeController = TextEditingController();

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
              UserInfoTextItemDisplayArea(
                title: 'ニックネーム',
                body: _nickName,
              ),
              UserInfoTextItemDisplayArea(
                title: 'Email',
                body: _email,
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
                            // Get.to(() => SchoolSearch());
                          },
                        )
                      ],
                    ),
                    SelectedSchoolListWidget(
                      list: _selectedSchoolList,
                    ),
                  ],
                ),
              ),
              UserInfoTextItemDisplayArea(
                title: 'exp',
                body: f.format(_exp),
              ),
              UserInfoTextItemDisplayArea(
                title: 'ポイント',
                body: f.format(_point),
              ),
              CustomTextAreaWidget(
                controller: _aboutMeController,
                title: REGISTER_ABOUT_ME_TITLE,
                errorText: _aboutMeController.text.isEmpty
                    ? REGISTER_ABOUT_ME_ERROR
                    : '',
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
