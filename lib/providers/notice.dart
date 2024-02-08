import 'dart:developer';

import 'package:find_friend/services/notice.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class NoticeProvider extends GetxController {
  RxList<RecordModel> notices = <RecordModel>[].obs;

  static NoticeProvider get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    NoticeService().getNoticesList().then((value) {
      log('NoticeProvider onInit $value');
      setNotices(value);
    });
  }

  void setNotices(List<RecordModel> data) {
    notices.clear();

    for (RecordModel record in data) {
      notices.add(record);
    }
  }
}
