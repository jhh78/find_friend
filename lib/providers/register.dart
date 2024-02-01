import 'package:find_friend/models/schools.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  RxString nickname = ''.obs;
  RxString email = ''.obs;
  RxList<Map<String, dynamic>> schoolInfo = <Map<String, dynamic>>[].obs;

  RxString nicknameError = ''.obs;
  RxString emailError = ''.obs;

  RxString fKind = ''.obs;
  RxString prefectures = ''.obs;
  RxString keyword = ''.obs;
  RxList<SchoolsTable> searchedSchoolList = <SchoolsTable>[].obs;
  RxList<SchoolsTable> seletedSchoolList = <SchoolsTable>[].obs;
  RxBool isSchoolValidateError = true.obs;

  void setIsSchoolValidateError(bool value) {
    isSchoolValidateError.value = value;
  }

  bool checkSchoolSearchValidateSuccess() {
    if (fKind.isEmpty || prefectures.isEmpty || keyword.isEmpty) {
      setIsSchoolValidateError(false);
      return false;
    }

    setIsSchoolValidateError(true);
    return true;
  }

  void setFkind(String value) {
    fKind.value = value;
  }

  void setPrefectures(String value) {
    prefectures.value = value;
  }

  void setKeyword(String value) {
    keyword.value = value;
  }

  void setsearchedSchoolList(List<SchoolsTable> value) {
    searchedSchoolList(value);
  }

  void setSeletedSchoolList(SchoolsTable value) {
    seletedSchoolList.add(value);
  }

  void setNickname(String value) {
    nickname.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setSchoolInfo(Map<String, dynamic> info) {
    schoolInfo.add(info);
  }

  bool isValidateSuccess() {
    debugPrint('nickname: ${nickname.value}');
    debugPrint('email: ${email.value}');
    if (nickname.value.isEmpty) {
      nicknameError(REGISTER_NICKNAME_ERROR);
    }

    if (email.value.isEmpty) {
      emailError(REGISTER_EMAIL_ERROR);
    }

    return nickname.value.isNotEmpty && email.value.isNotEmpty;
  }
}
