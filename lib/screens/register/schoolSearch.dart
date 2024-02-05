import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/userDefualtInfo.dart';
import 'package:find_friend/services/schools.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/message/schoolSearch.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/dropboxMenu.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchScreen extends StatelessWidget {
  SchoolSearchScreen({super.key});

  final UserDefaultInfoController controller =
      Get.put(UserDefaultInfoController());

  Widget _renderSearchResult(BuildContext context) {
    if (controller.searchedSchoolList.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.searchedSchoolList.length,
        itemBuilder: (context, index) {
          SchoolsTable school = controller.searchedSchoolList[index];
          debugPrint(school.name);

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: ListTile(
              leading: const Icon(Icons.school_outlined, color: Colors.black87),
              title: CustomTextWidget(
                text: school.name ?? '',
                kind: 'inputFieldTitle',
              ),
              splashColor: Colors.indigo[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                debugPrint('学校が選択されました $school');
                controller.setSeletedSchoolList(school);
                controller.initSchoolSearchForm();
                Get.back();
              },
            ),
          );
        },
      ),
    );
  }

  void _searchButtonClick() async {
    List<SchoolsTable> result = await SchoolsService().getSchoolList(
        controller.fKind.toString(),
        controller.prefectures.toString(),
        controller.keyword.toString());

    controller.setSearchedSchoolList(result);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackGroundImageWidget(type: 'bg1'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            centerTitle: true,
            title: const CustomTextWidget(
              text: SCHOOL_SEARCH_APPBAR_TITLE,
              kind: 'headTitle',
            ),
            iconTheme: const IconThemeData(
              color: Colors.black54,
            ),
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomDropBoxMenu(
                          label: SCHOOL_SEARCH_PREFECTURE_TEXT,
                          items: REGIONAL_CLASSIFICATION,
                          callBack: controller.setPrefectures,
                        ),
                        CustomDropBoxMenu(
                          label: SCHOOL_SEARCH_FACILITY_TYPE_TEXT,
                          items: FACILITY_CLASSIFICATION,
                          callBack: controller.setFkind,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextWidget(
                          text: SCHOOL_SEARCH_SCHOOL_NAME_TEXT,
                          kind: 'inputFieldTitle',
                        ),
                        TextField(
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: COLOR_MAP['text'],
                                  ),
                          decoration: InputDecoration(
                            hintText: SCHOOL_SEARCH_SCHOOL_NAME_HINT_TEXT,
                            hintStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: COLOR_MAP['hint'],
                                    ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          ),
                          onChanged: controller.setKeyword,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        if (!controller.isSchoolSearchFormValidate.value)
                          const CustomErrorWidget(
                            errorText: SCHOOL_SEARCH_ERROR_TEXT,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.blue[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            debugPrint('検索ボタンが押されました');

                            if (!controller
                                .checkSchoolSearchValidateSuccess()) {
                              return;
                            }

                            _searchButtonClick();
                          },
                          child: const CustomTextWidget(
                            text: SCHOOL_SEARCH_SEARCH_BUTTON_TEXT,
                            kind: 'inputFieldTitle',
                          ),
                        ),
                        Obx(
                          () => _renderSearchResult(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
