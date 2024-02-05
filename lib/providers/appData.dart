import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDataController extends GetxController {
  RxInt navibarCurrentIndex = 0.obs;
  final GlobalKey<NavigatorState> noticeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> threadNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> userInfoNavigatorKey =
      GlobalKey<NavigatorState>();

  RxList<Map<String, dynamic>> schoolInfo = <Map<String, dynamic>>[].obs;

  static AppDataController get to => Get.find();

  void changeNaviBarCurrentIndex(int index) {
    navibarCurrentIndex(index);
    debugPrint('navibarCurrentIndex: $navibarCurrentIndex');
  }

  void initNavigatorPops() {
    noticeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    threadNavigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void setSchoolInfo(Map<String, dynamic> info) {
    schoolInfo.add(info);
  }
}
