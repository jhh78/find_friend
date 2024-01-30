import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthModel {
  late Database db;

  Future initDb() async {
    try {
      var databaseRootPath = await getDatabasesPath();
      var databasePath = join(databaseRootPath, 'fiend_friend.db');

      db = await openDatabase(databasePath);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
