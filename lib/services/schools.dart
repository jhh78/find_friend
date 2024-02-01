import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/database.dart';
import 'package:flutter/foundation.dart';

class SchoolsService {
  Future<List<SchoolsTable>> getSchoolList(
      String fkind, String prefectures, String keyword) async {
    try {
      var db = await DatabaseService.initDb();
      List<SchoolsTable> list = [];
      List<Map<String, dynamic>> maps = await db.query(
        'schools',
        columns: ['*'],
        where: 'f_kind = ? and prefectures = ? and name like ?',
        whereArgs: [fkind, prefectures, '%$keyword%'],
      );

      for (var map in maps) {
        list.add(SchoolsTable.fromJson(map));
      }

      return list;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}
