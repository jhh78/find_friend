import 'package:find_friend/models/schools.dart';
import 'package:find_friend/models/system.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class UserDefaultInfoController extends GetxController {
  static UserDefaultInfoController get to => Get.find();

  RxBool isProcessing = false.obs;

  RxString nickname = ''.obs;
  RxString email = ''.obs;
  RxString aboutMe = ''.obs;
  RxList<Map<String, dynamic>> schoolInfo = <Map<String, dynamic>>[].obs;
  RxInt exp = 0.obs;
  RxInt point = 0.obs;

  RxString nicknameError = ''.obs;
  RxString emailError = ''.obs;
  RxString aboutMeError = ''.obs;

  RxString fKind = ''.obs;
  RxString prefectures = ''.obs;
  RxString keyword = ''.obs;
  RxList<SchoolsTable> searchedSchoolList = <SchoolsTable>[].obs;
  RxList<SchoolsTable> seletedSchoolList = <SchoolsTable>[].obs;
  RxBool isSchoolSearchFormValidate = true.obs;
  RxBool isRegisterFormSchoolValidate = true.obs;

  void setAboutMe(String value) {
    aboutMe.value = value;
  }

  void setIsProcessing(bool value) {
    isProcessing.value = value;
  }

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

    aboutMe.value.isEmpty
        ? aboutMeError(REGISTER_ABOUT_ME_ERROR)
        : aboutMeError('');

    seletedSchoolList.isEmpty
        ? isRegisterFormSchoolValidate(false)
        : isRegisterFormSchoolValidate(true);

    return nickname.value.isNotEmpty &&
        email.value.isNotEmpty &&
        aboutMe.value.isNotEmpty &&
        seletedSchoolList.isNotEmpty;
  }

  void getUserInfoData() async {
    try {
      final List<SystemTable> system = await SystemService().getItem('key');

      final pb = PocketBase(REMOTE_DB_URL);
      final RecordModel record = await pb.collection('users').getOne(
            system[0].data.toString(),
          );

      debugPrint('record: ${record.data['schools']}');

      email.value = record.data['email'];
      aboutMe.value = record.data['depiction'];
      nickname.value = record.data['nickname'];
      exp.value = record.data['exp'];
      point.value = record.data['point'];

      for (final Map<String, dynamic> school in record.data['schools']) {
        seletedSchoolList.add(SchoolsTable.fromJson(school));
      }
    } catch (error) {
      debugPrint('getUserInfoData: $error');
    }
  }
}
