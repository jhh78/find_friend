import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/models/thread.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class ThreadService {
  Future<List<ThreadTable>> getThreadList(List<SchoolsTable> schools) async {
    try {
      List<String> querys = [];

      for (var school in schools) {
        querys.add('school_code = "${school.uuid}"');
      }

      final pb = PocketBase(API_URL);
      final response = await pb.collection('thread').getList(
            page: 1,
            perPage: 50,
            filter: querys.join(' || '),
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
      final String? uuid = await SystemService().getItem('key');
      log('createThread called > $title, > $content, > $school > $uuid');
      // example create body
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
}
