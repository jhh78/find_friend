import 'dart:developer';

import 'package:find_friend/models/user.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/services/users.dart';
import 'package:get/get.dart';

class UserInfoProvider extends GetxController {
  final UsersService _userService = UsersService();
  final SystemService _systemService = SystemService();

  Rx<UsersTable> userInfo = UsersTable().obs;

  RxBool isProcessing = false.obs;

  static UserInfoProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    log('userInfo: ${userInfo.value}', name: 'UserInfoProvider');

    _systemService.getAuthKey().then((value) {
      log('authKey: $value', name: 'UserInfoProvider');
      if (value.isNotEmpty) {
        _userService.getUserInfoData(value).then((value) {
          userInfo.value = UsersTable.fromJson(value.data);
        });
      }
    });
  }
}
