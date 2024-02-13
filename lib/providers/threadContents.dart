import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class ThreadContentsProvider extends GetxController {
  final ThreadContentsService threadContentsService = ThreadContentsService();
  RxList<ThreadContentsTable> threadContentsList = <ThreadContentsTable>[].obs;

  @override
  void onInit() {
    super.onInit();
    log('ThreadDetailProvider onInit');
    String threadId = Get.arguments.id;
    threadContentsService.getContentsList(threadId).then((value) {
      threadContentsList.addAll(value);
      log(value.toString());

      // Subscribe to changes in any thread_contents record
      final pb = PocketBase(API_URL);
      pb.collection('thread_contents').subscribe('*', (e) {
        log('observeItem >>>> ${e.action} ${e.record} ${e.record!.collectionId}');

        if (e.action == 'delete') {
          threadContentsList
              .removeWhere((element) => element.id == e.record!.id);
        } else if (e.action == 'create') {
          Map<String, dynamic> params = {
            'id': e.record!.id,
            'thread_id': e.record!.data['thread_id'],
            'user_id': e.record!.data['user_id'],
            'nickname': e.record!.data['nickname'],
            'contents': e.record!.data['contents'],
            'created': e.record!.data['created_at'],
            'updated': e.record!.data['updated_at'],
          };

          threadContentsList(
              [ThreadContentsTable.fromJson(params), ...threadContentsList]);
        }
      }, filter: 'thread_id="$threadId"');
    });
  }

  @override
  void onClose() {
    super.onClose();
    log('ThreadDetailProvider onClose');

    // remove all '*' topic subscriptions
    final pb = PocketBase(API_URL);
    pb.collection('thread_contents').unsubscribe('*');
  }
}
