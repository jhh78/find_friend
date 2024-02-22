import 'package:find_friend/models/favorite.dart';
import 'package:find_friend/services/favorite.dart';
import 'package:get/get.dart';

class FavoriteProvider extends GetxController {
  final RxList<FavoriteTable> _favoriteItems = <FavoriteTable>[].obs;
  final FavoriteService _favoriteService = FavoriteService();

  List<FavoriteTable> get favoriteItems {
    return _favoriteItems;
  }

  @override
  void onInit() {
    super.onInit();
    initFavoriteList();
  }

  Future<void> initFavoriteList() async {
    _favoriteItems.value = await _favoriteService.getFavoritesList();
  }

  Future<void> addFavoriteThread(String threadId) async {
    _favoriteService.addFavoriteThread(threadId);
    _favoriteItems.value = await _favoriteService.getFavoritesList();
  }

  Future<void> removeFavoriteThread(String threadId) async {
    _favoriteService.removeFavoriteThread(threadId);
    _favoriteItems.value = await _favoriteService.getFavoritesList();
  }

  bool isFavoriteThread(String threadId) {
    return _favoriteItems.any((favorite) => favorite.threadId == threadId);
  }
}
