import 'dart:convert';

import 'package:find_friend/models/schools.dart';
import 'package:find_friend/utils/constants.dart';
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
}
