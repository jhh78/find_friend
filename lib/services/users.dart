import 'dart:convert';

import 'package:find_friend/models/system.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class UsersService {
  Future<RecordModel?> createItem(String nickname, String email) async {
    try {
      var pb = PocketBase(REMOTE_DB_URL);

      // example create body
      final body = <String, dynamic>{
        "username": nickname,
        "email": email,
        "exp": 999,
        "password": "jskfjfiwojfiwjfojeojfwe",
        "passwordConfirm": "jskfjfiwojfiwjfojeojfwe"
      };

      final record = await pb.collection('users').create(body: body);
      debugPrint(record.id);

      return record;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
