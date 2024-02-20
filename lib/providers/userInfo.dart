import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:get/get.dart';

class UserInfoProvider extends GetxController {
  final UsersService _userService = UsersService();
  final SystemService _systemService = SystemService();

  // userTableの中身
  RxString id = ''.obs;
  RxString created = ''.obs;
  RxString updated = ''.obs;
  RxString nickname = ''.obs;
  RxInt exp = 0.obs;
  RxInt point = 0.obs;
  RxString depiction = ''.obs;
  RxList<SchoolsTable> schools = <SchoolsTable>[].obs;

  RxBool isProcessing = false.obs;

  static UserInfoProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    initUserInfo();
  }

  Future<void> initUserInfo() async {
    try {
      _systemService.getAuthKey().then((value) {
        log('authKey: $value', name: 'UserInfoProvider');
        if (value.isNotEmpty) {
          _userService.getUserInfoData(value).then((value) {
            updateUserInfo({
              'id': value.id,
              'created': value.created,
              'updated': value.updated,
              'nickname': value.data["nickname"],
              'exp': value.data["exp"],
              'point': value.data["point"],
              'depiction': value.data["depiction"],
              'schools': value.data["schools"],
            });
          });
        }
      });
    } catch (e) {
      log('initUserInfo error: $e', name: 'UserInfoProvider');
      rethrow;
    }
  }

  void updateUserInfo(Map<String, dynamic> userInfo) {
    List<SchoolsTable> schoolsList = [];

    for (Map<String, dynamic> school in userInfo['schools']) {
      schoolsList.add(SchoolsTable.fromJson(school));
    }

    id.value = userInfo['id'];
    created.value = userInfo['created'];
    updated.value = userInfo['updated'];
    nickname.value = userInfo['nickname'];
    exp.value = userInfo['exp'];
    point.value = userInfo['point'];
    depiction.value = userInfo['depiction'];
    schools.value = schoolsList;
  }
}
