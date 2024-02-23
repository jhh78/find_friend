import 'package:find_friend/models/favorite.dart';
import 'package:find_friend/models/thread.dart';
import 'package:find_friend/services/favorite.dart';
import 'package:get/get.dart';

class FavoriteProvider extends GetxController {
  final RxList<FavoriteTable> favoriteItems = <FavoriteTable>[].obs;
  final RxList<ThreadTable> favoriteThreadItems = <ThreadTable>[].obs;
  final FavoriteService _favoriteService = FavoriteService();

  Future<void> initFavoriteList() async {
    try {
      List<FavoriteTable> lists = await _favoriteService.getFavoritesList();
      favoriteItems.clear();
      favoriteItems.addAll(lists);
      await getFavoriteThreadList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getFavoriteThreadList() async {
    try {
      List<ThreadTable> threadList =
          await _favoriteService.getFavoriteThreadList(favoriteItems);
      favoriteThreadItems.clear();
      favoriteThreadItems.addAll(threadList);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addFavoriteThread(String threadId) async {
    try {
      _favoriteService.addFavoriteThread(threadId);
      initFavoriteList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removeFavoriteThread(String threadId) async {
    try {
      await _favoriteService.removeFavoriteThread(threadId);
      initFavoriteList();
    } catch (error) {
      rethrow;
    }
  }

  bool isFavoriteThread(String threadId) {
    return favoriteItems.any((favorite) => favorite.threadId == threadId);
  }
}
