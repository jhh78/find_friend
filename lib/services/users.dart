import 'dart:convert';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class UsersService {
  Future<RecordModel> createItem(String nickname, String email,
      List<SchoolsTable> obj, String depiction) async {
    try {
      var pb = PocketBase(API_URL);

      List<Map<String, dynamic>> jsonString = [];

      for (var item in obj) {
        jsonString.add(item.toMap());
      }

      final body = <String, dynamic>{
        "nickname": nickname,
        "email": email,
        "exp": 0,
        "point": 10,
        "depiction": depiction,
        "schools": jsonEncode(jsonString),
      };

      final record = await pb.collection('users').create(body: body);
      return record;
    } catch (error) {
      rethrow;
    }
  }

  Future updateItem(String nickname, String email, List<SchoolsTable> obj,
      String depiction) async {
    try {
      final String? uuid = await SystemService().getItem('key');
      var pb = PocketBase(API_URL);

      List<Map<String, dynamic>> jsonString = [];

      for (var item in obj) {
        jsonString.add(item.toMap());
      }

      final body = <String, dynamic>{
        "nickname": nickname,
        "email": email,
        "exp": 0,
        "point": 10,
        "depiction": depiction,
        "schools": jsonEncode(jsonString),
      };

      final record =
          await pb.collection('users').update(uuid.toString(), body: body);
      return record.id;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserInfoData() async {
    try {
      final String? uuid = await SystemService().getItem('key');

      if (uuid == null) {
        return null;
      }

      final pb = PocketBase(API_URL);
      final RecordModel record = await pb.collection('users').getOne(uuid);

      return record.data;
    } catch (error) {
      return null;
    }
  }
}
