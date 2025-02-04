import 'dart:developer';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class UsersService {
  Future<RecordModel> createItem(String nickname, List<SchoolsTable> schools, String depiction) async {
    try {
      var pb = PocketBase(API_URL);

      List<Map<String, dynamic>> jsonString = [];

      for (SchoolsTable item in schools) {
        jsonString.add(item.toMap());
      }

      final body = <String, dynamic>{
        "nickname": nickname,
        "exp": REGISTER_DEAFULT_EXP,
        "point": REGISTER_DEAFULT_POINT,
        "depiction": depiction,
        "schools": jsonString,
      };

      final record = await pb.collection('users').create(body: body);
      return record;
    } catch (error) {
      log('createItem error: $error');
      rethrow;
    }
  }

  Future updateUserDefaultInfo(List<SchoolsTable> schools, String depiction) async {
    try {
      final String uuid = await SystemService().getAuthKey();
      var pb = PocketBase(API_URL);

      List<Map<String, dynamic>> jsonString = [];

      for (SchoolsTable item in schools) {
        jsonString.add(item.toMap());
      }

      final body = <String, dynamic>{
        "depiction": depiction,
        "schools": jsonString,
      };

      log('updateUserDefaultInfo body: $body', name: 'UsersService');

      final record = await pb.collection('users').update(uuid.toString(), body: body);
      return record.id;
    } catch (error) {
      log('updateItem error: $error');
      rethrow;
    }
  }

  Future updateUserPoint(int point, int exp) async {
    try {
      final String uuid = await SystemService().getAuthKey();
      var pb = PocketBase(API_URL);

      final body = <String, dynamic>{
        "point": point,
        "exp": exp,
      };

      log('updateUserPoint body: $body', name: 'UsersService');

      final record = await pb.collection('users').update(uuid.toString(), body: body);
      return record.id;
    } catch (error) {
      log('updateItem error: $error');
      rethrow;
    }
  }

  Future<RecordModel> getUserInfoData(String userId) async {
    try {
      final pb = PocketBase(API_URL);
      final RecordModel response = await pb.collection('users').getOne(userId);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
