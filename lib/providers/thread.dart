import 'dart:developer';

import 'package:find_friend/models/thread.dart';
import 'package:get/get.dart';

class ThreadProvider extends GetxController {
  RxList<ThreadTable> threadList = <ThreadTable>[].obs;

  static ThreadProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    log('ThreadProvider onInit');
  }

  void setThreadList(ThreadTable value) {
    threadList.add(value);
  }
}
