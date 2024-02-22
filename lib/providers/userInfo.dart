import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

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
      String authKey = await _systemService.getAuthKey();

      if (authKey.isNotEmpty) {
        RecordModel record = await _userService.getUserInfoData(authKey);

        updateUserInfo({
          'id': record.id,
          'created': record.created,
          'updated': record.updated,
          'nickname': record.data["nickname"],
          'exp': record.data["exp"],
          'point': record.data["point"],
          'depiction': record.data["depiction"],
          'schools': record.data["schools"],
        });
      }
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
