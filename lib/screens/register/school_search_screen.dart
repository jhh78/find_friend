import 'package:find_friend/models/schools.dart';
import 'package:find_friend/services/schools.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/message/school_search.dart';
import 'package:find_friend/widgets/common/backgroud_image.dart';
import 'package:find_friend/widgets/common/dropbox_menu.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/common/text_body.dart';
import 'package:find_friend/widgets/common/text_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchScreen extends StatefulWidget {
  const SchoolSearchScreen({super.key});

  @override
  State<SchoolSearchScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SchoolSearchScreen> {
  List<SchoolsTable> _result = [];
  String fKind = '';
  String sPrefecture = '';
  String keyword = '';

  bool error = false;

  Widget _renderSearchResult() {
    if (_result.isEmpty) {
      return const Center(
        child: Text(
          SCHOOL_SEARCH_NO_RESULT_TEXT,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _result.length,
      itemBuilder: (context, index) {
        SchoolsTable school = _result[index];
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
              debugPrint('学校が選択されました');
              Get.back();
            },
          ),
        );
      },
    );
  }

  void _searchButtonClick() async {
    debugPrint('検索ボタンが押されました');
    debugPrint('学校区分 : $fKind');
    debugPrint('都道府県 : $sPrefecture');

    setState(() {
      error = false;
    });

    if (fKind == '' || sPrefecture == '' || keyword == '') {
      setState(() {
        error = true;
      });

      return;
    }

    List<SchoolsTable> result =
        await SchoolsModel().getSchoolList(fKind, sPrefecture, keyword);
    setState(() {
      _result = result;
    });
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
              centerTitle: true,
              title:
                  const CustomTextTitleWidget(text: SCHOOL_SEARCH_APPBAR_TITLE),
              iconTheme: const IconThemeData(
                color: Colors.black54,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomDropBoxMenu(
                    label: SCHOOL_SEARCH_PREFECTURE_TEXT,
                    items: REGIONAL_CLASSIFICATION,
                    callBack: (value) {
                      debugPrint('都道府県 : $value');
                      setState(() {
                        sPrefecture = value;
                      });
                    },
                  ),
                  CustomDropBoxMenu(
                    label: SCHOOL_SEARCH_FACILITY_TYPE_TEXT,
                    items: FACILITY_CLASSIFICATION,
                    callBack: (value) {
                      debugPrint('学校区分 : $value');
                      setState(() {
                        fKind = value;
                      });
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
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: COLOR_MAP['text'],
                                  ),
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
                          onChanged: (value) {
                            debugPrint('value : $value');
                            setState(() {
                              keyword = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  if (error)
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
                      _searchButtonClick();
                    },
                    child: const Text(
                      SCHOOL_SEARCH_SEARCH_BUTTON_TEXT,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(child: _renderSearchResult()),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
