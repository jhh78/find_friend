import 'dart:io';

import 'package:find_friend/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<Database> initDb() async {
    try {
      var databaseRootPath = await getDatabasesPath();
      var databasePath = join(databaseRootPath, DATABASE_NAME);

      var file = File(databasePath);

      // db 파일이 없을 경우에만 복사
      if (!await file.exists()) {
        ByteData data = await rootBundle.load("assets/$DATABASE_NAME");
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(databasePath).writeAsBytes(bytes);
      }

      return await openDatabase(databasePath);
    } catch (error) {
      rethrow;
    }
  }
}
