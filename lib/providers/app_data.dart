import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppDataController extends GetxController {
  int navibarCurrentIndex = 0;

  void setNaviBarCurrentIndex(int index) {
    navibarCurrentIndex = index;
    update();
  }
}
