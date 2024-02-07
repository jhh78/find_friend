import 'package:find_friend/models/schools.dart';
import 'package:get/get.dart';

class SchoolSearchProvider extends GetxController {
  RxList<SchoolsTable> searchedSchoolList = <SchoolsTable>[].obs;

  static SchoolSearchProvider get to => Get.find();

  void setSearchedSchoolList(List<SchoolsTable> value) {
    searchedSchoolList.value = value;
  }
}
