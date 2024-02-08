import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDataProvider extends GetxController {
  RxInt navibarCurrentIndex = 0.obs;
  final GlobalKey<NavigatorState> noticeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> threadNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> userInfoNavigatorKey =
      GlobalKey<NavigatorState>();

  static AppDataProvider get to => Get.find();

  RxBool isProcessing = false.obs;

  void setIsProcessing(bool value) {
    isProcessing(value);
  }

  void changeNaviBarCurrentIndex(int index) {
    navibarCurrentIndex(index);
  }
}
