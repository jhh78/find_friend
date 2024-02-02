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
  RxBool isSchoolSearchFormValidate = true.obs;
  RxBool isRegisterFormSchoolValidate = true.obs;

  void setIsisSchoolSearchFormValidate(bool value) {
    isSchoolSearchFormValidate.value = value;
  }

  void initSchoolSearchForm() {
    fKind.value = '';
    prefectures.value = '';
    keyword.value = '';
    searchedSchoolList.clear();
  }

  bool checkSchoolSearchValidateSuccess() {
    debugPrint(
        'fKind: ${fKind.isEmpty || prefectures.isEmpty || keyword.isEmpty}');
    if (fKind.isEmpty || prefectures.isEmpty || keyword.isEmpty) {
      setIsisSchoolSearchFormValidate(false);
      return false;
    }

    setIsisSchoolSearchFormValidate(true);
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

  void setSearchedSchoolList(List<SchoolsTable>? value) {
    searchedSchoolList(value);
  }

  void initSearchedSchoolList() {
    searchedSchoolList.clear();
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

    nickname.value.isEmpty
        ? nicknameError(REGISTER_NICKNAME_ERROR)
        : nicknameError('');
    email.value.isEmpty ? emailError(REGISTER_EMAIL_ERROR) : emailError('');
    seletedSchoolList.isEmpty
        ? isRegisterFormSchoolValidate(false)
        : isRegisterFormSchoolValidate(true);

    return nickname.value.isNotEmpty &&
        email.value.isNotEmpty &&
        seletedSchoolList.isNotEmpty;
  }
}
