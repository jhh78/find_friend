import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:get/get.dart';

class RegisterProvider extends GetxController {
  RxBool isProcessing = false.obs;
  RxList<SchoolsTable> selectedSchools = <SchoolsTable>[].obs;
  RxList<SchoolsTable> searchedSchools = <SchoolsTable>[].obs;

  static RegisterProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    log('RegisterProvider onInit', name: 'RegisterProvider');
  }

  @override
  void onClose() {
    super.onClose();
    log('RegisterProvider onClose', name: 'RegisterProvider');
  }
}
