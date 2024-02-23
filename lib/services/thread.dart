import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/models/thread.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class ThreadService {
  Future<List<ThreadTable>> getThreadList(
      List<SchoolsTable> schools, int currentPage, int perPage) async {
    try {
      log('getThreadList called > $currentPage', name: 'ThreadService');
      List<String> querys = [];

      for (var school in schools) {
        querys.add('school_code = "${school.uuid}"');
      }

      final pb = PocketBase(API_URL);
      final response = await pb.collection('thread').getList(
            page: currentPage,
            perPage: perPage,
            filter: querys.join(' || '),
            sort: '-created',
          );

      List<ThreadTable> threadList = [];

      for (var item in response.items) {
        Map<String, dynamic> params = {
          'id': item.id,
          'created': item.created,
          'school_code': item.data['school_code'],
          'user_id': item.data['user_id'],
          'title': item.data['title'],
          'depiction': item.data['depiction'],
        };

        threadList.add(ThreadTable.fromJson(params));
      }

      return threadList;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ThreadTable>> getFavoriteThreadList(
      List<String> threadIds) async {
    try {
      log('getFavoriteThreadList called > ', name: 'ThreadService');
      List<String> querys = [];

      for (String threadId in threadIds) {
        querys.add('id = "$threadId"');
      }

      final pb = PocketBase(API_URL);
      final response = await pb.collection('thread').getList(
            filter: querys.join(' || '),
            sort: '-created',
          );

      List<ThreadTable> threadList = [];

      for (var item in response.items) {
        Map<String, dynamic> params = {
          'id': item.id,
          'created': item.created,
          'school_code': item.data['school_code'],
          'user_id': item.data['user_id'],
          'title': item.data['title'],
          'depiction': item.data['depiction'],
        };

        threadList.add(ThreadTable.fromJson(params));
      }

      return threadList;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createThread({
    required String title,
    required String content,
    required String school,
  }) async {
    try {
      final String uuid = await SystemService().getAuthKey();
      log('createThread called > $title, > $content, > $school > $uuid');
      final pb = PocketBase(API_URL);
      final body = <String, dynamic>{
        "school_code": school,
        "user_id": uuid,
        "title": title,
        "depiction": content,
      };

      await pb.collection('thread').create(body: body);
    } catch (error) {
      rethrow;
    }
  }

  Future deleteThread(String threadId) async {
    try {
      log('deleteThread called > $threadId');
      final pb = PocketBase(API_URL);
      await pb.collection('thread').delete(threadId);
    } catch (error) {
      rethrow;
    }
  }
}
