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
  RxString selectedSchool = ''.obs;

  static ThreadProvider get to => Get.find();

  void initValues() {
    currentPage.value = 1;
    selectedSchool.value = '';
    threadList.clear();
  }

  Future<void> initThreadList() async {
    try {
      initValues();
      List<ThreadTable> list = await _searchThreadList(1);
      threadList.addAll(list);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getNextThreadList() async {
    try {
      final int nextPage = currentPage.value + 1;

      List<ThreadTable> list = await _searchThreadList(nextPage);
      if (list.isNotEmpty) {
        currentPage.value = nextPage;
        threadList.addAll(list);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ThreadTable>> _searchThreadList(int nextPage) async {
    try {
      List<ThreadTable> list = await threadService.getThreadList(
          userInfoProvider.schools, nextPage, PAGE_PER_ITEM);
      return list;
    } catch (error) {
      rethrow;
    }
  }
}
