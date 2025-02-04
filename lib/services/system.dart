import 'dart:developer';

import 'package:find_friend/services/database.dart';
import 'package:sqflite/sqflite.dart';

class SystemService {
  Future<String> getAuthKey() async {
    try {
      var db = await DatabaseService.initDb();
      List<Map<String, dynamic>> maps = await db.query(
        'system',
        where: 'kind = "key"',
        limit: 1,
      );

      return maps.isEmpty ? '' : maps[0]['data'];
    } catch (error) {
      log('SystemService getItem error: $error');
      rethrow;
    }
  }

  Future createItem(String kind, String uuid) async {
    try {
      var db = await DatabaseService.initDb();
      await db.insert(
        'system',
        {
          'kind': kind,
          'data': uuid,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      log('SystemService createItem error: $error');
      rethrow;
    }
  }
}
