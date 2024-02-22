import 'dart:developer';

import 'package:find_friend/models/favorite.dart';
import 'package:find_friend/models/thread.dart';
import 'package:find_friend/services/database.dart';
import 'package:find_friend/services/thread.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteService {
  final ThreadService _threadService = ThreadService();

  Future<List<ThreadTable>> getFavoriteThreadList(
      List<FavoriteTable> favorites) async {
    try {
      if (favorites.isNotEmpty) {
        List<String> threadIds = List.generate(favorites.length, (i) {
          return favorites[i].threadId.toString();
        });

        List<ThreadTable> threads =
            await _threadService.getFavoriteThreadList(threadIds);
        return threads;
      }
      return [];
    } catch (error) {
      log('FavoriteService getFavoriteThreadList error: $error',
          name: 'FavoriteService');
      rethrow;
    }
  }

  Future<List<FavoriteTable>> getFavoritesList() async {
    try {
      var db = await DatabaseService.initDb();
      List<Map<String, dynamic>> maps = await db.query('favorite');

      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return FavoriteTable(
            threadId: maps[i]['thread_id'],
          );
        });
      }
      return [];
    } catch (error) {
      log('FavoriteService _getFavoritesList error: $error',
          name: 'FavoriteService');
      rethrow;
    }
  }

  Future<void> addFavoriteThread(String threadId) async {
    try {
      var db = await DatabaseService.initDb();
      await db.insert(
        'favorite',
        {
          'thread_id': threadId,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      log('FavoriteService addFavoriteThread error: $error',
          name: 'FavoriteService');
      rethrow;
    }
  }

  Future<void> removeFavoriteThread(String threadId) async {
    try {
      var db = await DatabaseService.initDb();
      await db.delete(
        'favorite',
        where: 'thread_id = ?',
        whereArgs: [threadId],
      );
    } catch (error) {
      log('FavoriteService removeFavoriteThread error: $error',
          name: 'FavoriteService');
      rethrow;
    }
  }
}
