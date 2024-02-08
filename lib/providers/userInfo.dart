import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/users.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class UserInfoProvider extends GetxController {
  RxMap<String, String> validate = <String, String>{}.obs;

  RxString nickName = ''.obs;
  RxString email = ''.obs;
  RxString aboutMe = ''.obs;
  RxList<SchoolsTable> selectedSchoolList = <SchoolsTable>[].obs;

  RxInt exp = 0.obs;
  RxInt point = 0.obs;

  RxBool isProcessing = false.obs;

  static UserInfoProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    log('>>>>>>>>>>>>>>> UserInfoProvider onInit');
    UsersService().getUserInfoData().then((value) {
      if (value != null) {
        setNickName(value['nickname']);
        setEmail(value['email']);
        setAboutMe(value['depiction']);
        setExp(value['exp']);
        setPoint(value['point']);
        setAboutMe(value['depiction']);

        List<SchoolsTable> schools = [];
        for (var item in value['schools']) {
          schools.add(SchoolsTable.fromJson(item));
        }

        selectedSchoolList(schools);
      }
    });
  }

  void initValue(RecordModel model) {
    setNickName(model.data['nickname']);
    setEmail(model.data['email']);
    setAboutMe(model.data['depiction']);
    setExp(model.data['exp']);
    setPoint(model.data['point']);
    setAboutMe(model.data['depiction']);

    List<SchoolsTable> schools = [];
    for (var item in model.data['schools']) {
      schools.add(SchoolsTable.fromJson(item));
    }

    selectedSchoolList(schools);
  }

  void setNickName(String value) {
    nickName.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setAboutMe(String value) {
    aboutMe.value = value;
  }

  void setExp(int value) {
    exp.value = value;
  }

  void setPoint(int value) {
    point.value = value;
  }

  // TODO: 중복처리하하기
  void setSelectedSchoolList(SchoolsTable value) {
    selectedSchoolList.add(value);
  }

  void setIsProcessing(bool value) {
    isProcessing.value = value;
  }

  void doFormDataValidate(String nickname, String email, String aboutMe,
      List<SchoolsTable> seletedSchoolList) {
    validate.clear();

    if (nickname.isEmpty) {
      validate['nickName'] = REGISTER_NICKNAME_ERROR;
    }
    if (email.isEmpty) {
      validate['email'] = REGISTER_EMAIL_ERROR;
    }
    if (aboutMe.isEmpty) {
      validate['aboutMe'] = REGISTER_ABOUT_ME_ERROR;
    }
    if (seletedSchoolList.isEmpty) {
      validate['schools'] = SCHOOL_SEARCH_ERROR;
    }
  }
}
