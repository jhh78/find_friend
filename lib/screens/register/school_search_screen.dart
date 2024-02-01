import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/register.dart';
import 'package:find_friend/services/schools.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/message/school_search.dart';
import 'package:find_friend/widgets/common/backgroud_image.dart';
import 'package:find_friend/widgets/common/dropbox_menu.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/common/text_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchScreen extends GetView<RegisterController> {
  const SchoolSearchScreen({super.key});

  Widget _renderSearchResult(BuildContext context) {
    if (controller.searchedSchoolList.isEmpty) {
      return Center(
        child: Text(
          SCHOOL_SEARCH_NO_RESULT_TEXT,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: COLOR_MAP['text'],
              ),
        ),
      );
    }

    return ListView.builder(
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
            title: Text(school.name ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            splashColor: Colors.indigo[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              debugPrint('学校が選択されました $school');
              controller.setSeletedSchoolList(school);
              Get.back();
            },
          ),
        );
      },
    );
  }

  void _searchButtonClick() async {
    debugPrint('検索ボタンが押されました');

    List<SchoolsTable> result = await SchoolsService().getSchoolList(
        controller.fKind.toString(),
        controller.prefectures.toString(),
        controller.keyword.toString());

    controller.setsearchedSchoolList(result);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackGroundImageWidget(type: 'bg1'),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              centerTitle: true,
              title:
                  const CustomTextTitleWidget(text: SCHOOL_SEARCH_APPBAR_TITLE),
              iconTheme: const IconThemeData(
                color: Colors.black54,
              ),
            ),
            body: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomDropBoxMenu(
                      label: SCHOOL_SEARCH_PREFECTURE_TEXT,
                      items: REGIONAL_CLASSIFICATION,
                      callBack: (value) {
                        debugPrint('都道府県 : $value');
                        controller.setPrefectures(value);
                      },
                    ),
                    CustomDropBoxMenu(
                      label: SCHOOL_SEARCH_FACILITY_TYPE_TEXT,
                      items: FACILITY_CLASSIFICATION,
                      callBack: (value) {
                        debugPrint('学校区分 : $value');
                        controller.setFkind(value);
                      },
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SCHOOL_SEARCH_SCHOOL_NAME_TEXT,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: COLOR_MAP['text'],
                                ),
                          ),
                          TextField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: COLOR_MAP['text'],
                                ),
                            decoration: InputDecoration(
                              hintText: SCHOOL_SEARCH_SCHOOL_NAME_HINT_TEXT,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: COLOR_MAP['hint'],
                                  ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              debugPrint('value : $value');
                              controller.setKeyword(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    if (!controller.isSchoolValidateError.value)
                      const CustomErrorWidget(
                          errorText: SCHOOL_SEARCH_ERROR_TEXT),
                    const SizedBox(
                      height: 5,
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

                        if (!controller.checkSchoolSearchValidateSuccess()) {
                          return;
                        }

                        _searchButtonClick();
                      },
                      child: Text(
                        SCHOOL_SEARCH_SEARCH_BUTTON_TEXT,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                    Expanded(child: _renderSearchResult(context)),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
