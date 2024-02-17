import 'package:find_friend/services/system.dart';
import 'package:get/get.dart';

class FavoriteProvider extends GetxController {
  RxList<String> favoriteList = <String>[].obs;

  static get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // get favorite list from local storage
    SystemService().getAuthKey().then((value) {
      if (value != null) {
        favoriteList.addAll(value.split(','));
      }
    });
  }

  void addFavorite(String id) {
    favoriteList.add(id);
    // save favorite list to local storage
  }

  void removeFavorite(String id) {
    favoriteList.remove(id);
    // save favorite list to local storage
  }
}
