import 'dart:convert';
import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class UsersService {
  Future<RecordModel> createItem(
      String nickname, List<SchoolsTable> obj, String depiction) async {
    try {
      var pb = PocketBase(API_URL);

      List<Map<String, dynamic>> jsonString = [];

      for (var item in obj) {
        jsonString.add(item.toMap());
      }

      final body = <String, dynamic>{
        "nickname": nickname,
        "exp": 0,
        "point": 10,
        "depiction": depiction,
        "schools": jsonEncode(jsonString),
      };

      log('body: $body');

      final record = await pb.collection('users').create(body: body);
      return record;
    } catch (error) {
      log('createItem error: $error');
      rethrow;
    }
  }

  Future updateItem(
      String nickname, List<SchoolsTable> obj, String depiction) async {
    try {
      final String? uuid = await SystemService().getItem('key');
      var pb = PocketBase(API_URL);

      List<Map<String, dynamic>> jsonString = [];

      for (var item in obj) {
        jsonString.add(item.toMap());
      }

      final body = <String, dynamic>{
        "nickname": nickname,
        "exp": 0,
        "point": 10,
        "depiction": depiction,
        "schools": jsonEncode(jsonString),
      };

      final record =
          await pb.collection('users').update(uuid.toString(), body: body);
      return record.id;
    } catch (error) {
      log('updateItem error: $error');
      rethrow;
    }
  }

  Future<RecordModel?> getUserInfoData() async {
    try {
      final String? uuid = await SystemService().getItem('key');

      if (uuid == null) {
        return null;
      }

      final pb = PocketBase(API_URL);
      final RecordModel response = await pb.collection('users').getOne(uuid);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
