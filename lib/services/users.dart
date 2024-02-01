import 'dart:convert';

import 'package:find_friend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class UsersService {
  Future createItem() async {
    try {
      var pb = PocketBase(REMOTE_DB_URL);

      // example create body
      final body = <String, dynamic>{
        "username": "test_username",
        "email": "vkcel800@gmail.com",
        "password": "vkcel800@gmail.com",
        "passwordConfirm": "vkcel800@gmail.com"
      };

      final record = await pb.collection('users').create(body: body);
      debugPrint(record.id);

      return {"status": 200, "data": record};
    } catch (error) {
      return {"status": 500};
    }
  }
}
