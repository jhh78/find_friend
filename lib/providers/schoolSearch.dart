import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SchoolSearchProvider extends GetxController {
  RxString prefecture = ''.obs;
  RxString facility = ''.obs;
  RxBool isProcessing = false.obs;

  static SchoolSearchProvider get to => Get.find();

  void setIsProcessing(bool value) {
    isProcessing(value);
  }

  void setPrefecture(String value) {
    debugPrint('setPrefecture: $value');
    prefecture(value);
  }

  void setFacility(String value) {
    facility(value);
  }
}
