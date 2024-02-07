import 'package:find_friend/models/schools.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:get/get.dart';

class UserInfoProvider extends GetxController {
  RxMap<String, String> validate = <String, String>{}.obs;

  RxString nickName = ''.obs;
  RxString email = ''.obs;
  RxString aboutMe = ''.obs;
  RxList<SchoolsTable> selectedSchoolList = <SchoolsTable>[].obs;

  RxBool isProcessing = false.obs;

  static UserInfoProvider get to => Get.find();

  void setNickName(String value) {
    nickName.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setAboutMe(String value) {
    aboutMe.value = value;
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
