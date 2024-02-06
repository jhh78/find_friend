import 'dart:convert';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/models/system.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class UsersService {
  Future createItem(String nickname, String email, List<SchoolsTable> obj,
      String depiction) async {
    try {
      var pb = PocketBase(REMOTE_DB_URL);

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
      return record.id;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserInfoData() async {
    try {
      final List<SystemTable> system = await SystemService().getItem('key');

      final pb = PocketBase(REMOTE_DB_URL);
      final RecordModel record = await pb.collection('users').getOne(
            system[0].data.toString(),
          );

      return record.data;
    } catch (error) {
      debugPrint('getUserInfoData: $error');
      return null;
    }
  }
}
