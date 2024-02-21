import 'dart:developer';

import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class ThreadContentsService {
  Future<void> createItem({
    required String threadId,
    required String nickname,
    required String contents,
  }) async {
    try {
      var authKey = await SystemService().getAuthKey();

      final pb = PocketBase(API_URL);

      final body = <String, dynamic>{
        "thread_id": threadId,
        "user_id": authKey,
        "nickname": nickname,
        "contents": contents,
      };

      log('createItem body > $body');

      await pb.collection('thread_contents').create(body: body);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ThreadContentsTable>> getContentsList(
      String threadId, int currentPage) async {
    try {
      log('getContentsList threadId > $threadId currentPage > $currentPage',
          name: 'getContentsList');
      final pb = PocketBase(API_URL);
      final response = await pb.collection('thread_contents').getList(
            page: currentPage,
            perPage: PAGE_PER_ITEM,
            filter: 'thread_id = "$threadId"',
            sort: '-created',
          );
      final List<ThreadContentsTable> threadList = [];

      for (RecordModel item in response.items) {
        var params = {
          'id': item.id,
          'created': item.created,
          'updated': item.updated,
          'thread_id': item.data['thread_id'],
          'user_id': item.data['user_id'],
          'nickname': item.data['nickname'],
          'contents': item.data['contents'],
        };

        threadList.add(ThreadContentsTable.fromJson(params));
      }

      return threadList;
    } catch (error) {
      log('getThreadContents error > $error');
      rethrow;
    }
  }

  Future sendMessage(
      String fromUser, String toUser, String message, String oriMessage) async {
    try {
      final pb = PocketBase(API_URL);
      final body = <String, dynamic>{
        "from_user": fromUser,
        "to_user": toUser,
        "message": message,
        "ori_message": oriMessage
      };

      await pb.collection('message').create(body: body);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final pb = PocketBase(API_URL);
      await pb.collection('thread_contents').delete(id);
    } catch (error) {
      rethrow;
    }
  }
}
