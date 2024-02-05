import 'package:find_friend/models/system.dart';
import 'package:find_friend/services/database.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class SystemService {
  Future<List<SystemTable>> getItem(String kind) async {
    try {
      var db = await DatabaseService.initDb();
      List<SystemTable> list = [];
      List<Map<String, dynamic>> maps = await db.query(
        'system',
        where: 'kind = ?',
        whereArgs: [kind],
      );

      for (var map in maps) {
        list.add(SystemTable.fromJson(map));
      }

      return list;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future createItem(String kind, String uuid) async {
    try {
      var db = await DatabaseService.initDb();
      var res = await db.insert(
        'system',
        {
          'kind': kind,
          'data': uuid,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('createItem: $res');
    } catch (error) {
      debugPrint('>>>>> $error');
      rethrow;
    }
  }
}
