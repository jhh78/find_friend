import 'package:find_friend/models/favorite.dart';
import 'package:find_friend/models/thread.dart';
import 'package:find_friend/services/favorite.dart';
import 'package:get/get.dart';

class FavoriteProvider extends GetxController {
  final RxList<FavoriteTable> favoriteItems = <FavoriteTable>[].obs;
  final RxList<ThreadTable> favoriteThreadItems = <ThreadTable>[].obs;
  final FavoriteService _favoriteService = FavoriteService();

  @override
  void onInit() {
    super.onInit();
    initFavoriteList();
  }

  Future<void> initFavoriteList() async {
    List<FavoriteTable> lists = await _favoriteService.getFavoritesList();
    favoriteItems.clear();
    favoriteItems.addAll(lists);
    await getFavoriteThreadList();
  }

  Future<void> getFavoriteThreadList() async {
    List<ThreadTable> threadList =
        await _favoriteService.getFavoriteThreadList(favoriteItems);
    favoriteThreadItems.clear();
    favoriteThreadItems.addAll(threadList);
  }

  Future<void> addFavoriteThread(String threadId) async {
    _favoriteService.addFavoriteThread(threadId);
    initFavoriteList();
  }

  Future<void> removeFavoriteThread(String threadId) async {
    await _favoriteService.removeFavoriteThread(threadId);
    initFavoriteList();
  }

  bool isFavoriteThread(String threadId) {
    return favoriteItems.any((favorite) => favorite.threadId == threadId);
  }
}
