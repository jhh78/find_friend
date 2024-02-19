import 'package:find_friend/models/schools.dart';
import 'package:find_friend/models/thread.dart';
import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/thread.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/dropboxMenu.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/common/textArea.dart';
import 'package:find_friend/widgets/common/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadCreateForm extends StatelessWidget {
  ThreadCreateForm({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final ThreadProvider threadProvider = Get.put(ThreadProvider());
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  final ThreadService _threadService = ThreadService();
  String _selectedSchool = '';

  void _doValidate() {
    if (_selectedSchool.isEmpty) {
      throw Exception('学校を選択してください');
    }

    if (_titleController.text.isEmpty) {
      throw Exception('タイトルを入力してください');
    }

    if (_contentController.text.isEmpty) {
      throw Exception('スレット説明を入力してください');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> schoolList = [];

    for (SchoolsTable school in userInfoProvider.userInfo.value.schools ?? []) {
      Map<String, dynamic> schoolMap = {
        'value': school.uuid,
        'label': school.name,
      };
      schoolList.add(schoolMap);
    }

    return PopScope(
      onPopInvoked: (didPop) async {
        List<ThreadTable> response = await _threadService.getThreadList(
            userInfoProvider.userInfo.value.schools ?? [], 1, PAGE_PER_ITEM);
        threadProvider.threadList.clear();
        threadProvider.threadList.addAll(response);
        threadProvider.currentPage(1);
      },
      child: Stack(
        children: [
          const CustomBackGroundImageWidget(type: 'bg'),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: const CustomTextWidget(
                text: 'スレット作成',
                kind: 'headTitle',
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFieldWidget(
                    isRequired: true,
                    controller: _titleController,
                    hintText: 'スレット名を入力してください',
                    title: 'スレット名',
                  ),
                  CustomDropBoxMenu(
                    isRequired: true,
                    isExpanded: true,
                    label: '学校選択',
                    items: schoolList,
                    onSelected: (value) {
                      _selectedSchool = value;
                    },
                  ),
                  CustomTextAreaWidget(
                    isRequired: true,
                    controller: _contentController,
                    title: 'スレット説明',
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
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
              onPressed: () async {
                try {
                  _doValidate();

                  // 스레드 생성 로직
                  await _threadService.createThread(
                    title: _titleController.text,
                    content: _contentController.text,
                    school: _selectedSchool,
                  );

                  Get.back();
                } catch (error) {
                  CustomSnackbar.showErrorSnackbar(
                    title: '処理失敗',
                    error: error,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
