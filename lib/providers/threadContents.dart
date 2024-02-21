import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class ThreadContentsProvider extends GetxController {
  final ThreadContentsService threadContentsService = ThreadContentsService();
  RxList<ThreadContentsTable> threadContentsList = <ThreadContentsTable>[].obs;

  RxInt currentPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    log('ThreadContentsProvider onInit', name: 'thread_contents');
    initThreadContentsList();
  }

  @override
  void onClose() {
    super.onClose();
    log('ThreadContentsProvider onClose', name: 'thread_contents');
    removeSubscribedThreadContents();
  }

  String getThreadId() => Get.arguments.id;

  void initValues() {
    currentPage.value = 1;
    threadContentsList.clear();
  }

  void initThreadContentsList() async {
    try {
      initValues();
      List<ThreadContentsTable> lists = await _searchThreadContentsList(1);
      threadContentsList.addAll(lists);
      addSubscribedThreadContents();
    } catch (error) {
      rethrow;
    }
  }

  void getNextThreadContentsList() async {
    try {
      final int nextPage = currentPage.value + 1;

      List<ThreadContentsTable> lists =
          await _searchThreadContentsList(nextPage);
      if (lists.isNotEmpty) {
        currentPage.value = nextPage;
        threadContentsList.addAll(lists);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ThreadContentsTable>> _searchThreadContentsList(
      int nextPage) async {
    try {
      String threadId = getThreadId();
      List<ThreadContentsTable> lists =
          await threadContentsService.getContentsList(threadId, nextPage);
      return lists;
    } catch (error) {
      rethrow;
    }
  }

  void addSubscribedThreadContents() {
    String threadId = getThreadId();
    final pb = PocketBase(API_URL);
    pb.collection('thread_contents').subscribe('*', (e) {
      log('observeItem >>>> ${e.action} ${e.record} ${e.record!.collectionId}',
          name: 'thread_contents');

      if (e.action == 'delete') {
        threadContentsList.removeWhere((element) => element.id == e.record!.id);
      } else if (e.action == 'create') {
        Map<String, dynamic> params = {
          'id': e.record!.id,
          'thread_id': e.record!.data['thread_id'],
          'user_id': e.record!.data['user_id'],
          'nickname': e.record!.data['nickname'],
          'contents': e.record!.data['contents'],
          'created': e.record!.created,
          'updated': e.record!.updated,
        };

        threadContentsList(
            [ThreadContentsTable.fromJson(params), ...threadContentsList]);
      }
    }, filter: 'thread_id="$threadId"');
  }

  void removeSubscribedThreadContents() {
    final pb = PocketBase(API_URL);
    pb.collection('thread_contents').unsubscribe();
  }
}
