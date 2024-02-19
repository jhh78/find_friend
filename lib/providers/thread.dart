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

  RxInt currentPage = 1.obs;

  static ThreadProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    threadService
        .getThreadList(
            userInfoProvider.userInfo.value.schools ?? [], 1, PAGE_PER_ITEM)
        .then(
      (value) {
        log('threadList: $value', name: 'ThreadProvider');
        threadList.clear();
        threadList.addAll(value);
      },
    );
  }
}
