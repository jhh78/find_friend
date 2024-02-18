import 'dart:developer';

import 'package:find_friend/models/thread.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/thread.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:get/get.dart';

class ThreadProvider extends GetxController {
  final userInfoProvider = Get.put(UserInfoProvider());

  final threadService = ThreadService();

  RxList<ThreadTable> threadList = <ThreadTable>[].obs;
  RxMap<String, dynamic> validate = <String, dynamic>{}.obs;

  RxBool threadCreateError = false.obs;
  String formSchoolField = '';

  RxInt currentPage = 1.obs;

  static ThreadProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // threadService
    //     .getThreadList(userInfoProvider.selectedSchoolList, 1, PAGE_PER_ITEM)
    //     .then(
    //   (value) {
    //     initThreadListForValue(value);
    //   },
    // );
  }

  void setCurrentPage(int value) {
    currentPage.value = value;
  }

  void setThreadList(ThreadTable value) {
    log('setThreadList called > $value');
    threadList.add(value);
  }

  void initThreadListForValue(List<ThreadTable> value) {
    threadList.clear();
    threadList.addAll(value);
  }

  void setThreadCreateError(bool value) {
    threadCreateError.value = value;
  }

  void setFormSchoolField(String value) {
    formSchoolField = value;
  }

  bool isValidateSuccess(String title, String content, String school) {
    log('isValidateSuccess called > $title, > $content, > $school');
    validate.clear();

    if (school.isEmpty) {
      validate['school'] = '学校を選択してください';
    }

    if (title.isEmpty) {
      validate['title'] = 'タイトルを入力してください';
    }

    if (content.isEmpty) {
      validate['content'] = '内容を入力してください';
    }

    return validate.isEmpty;
  }
}
