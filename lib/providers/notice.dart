import 'package:find_friend/services/notice.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class NoticeProvider extends GetxController {
  RxList<RecordModel> notices = <RecordModel>[].obs;
  final NoticeService noticeService = NoticeService();

  static NoticeProvider get to => Get.find();

  void initNoticeList() async {
    try {
      final List<RecordModel> data = await noticeService.getNoticesList();
      notices.clear();
      notices.addAll(data);
    } catch (e) {
      rethrow;
    }
  }
}
