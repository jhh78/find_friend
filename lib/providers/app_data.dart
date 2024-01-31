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

  RxString facilityClassification = ''.obs;
  RxString regionalClassification = ''.obs;

  static AppDataController get to => Get.find();

  void changeNaviBarCurrentIndex(int index) {
    navibarCurrentIndex(index);
    debugPrint('navibarCurrentIndex: $navibarCurrentIndex');
  }

  void initNavigatorPops() {
    noticeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    threadNavigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void setFacilityClassification(String value) {
    facilityClassification(value);
  }

  void setRegionalClassification(String value) {
    regionalClassification(value);
  }
}
