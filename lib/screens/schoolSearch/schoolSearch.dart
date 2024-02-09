import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/schoolSearch.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/schools.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:find_friend/utils/message/schoolSearch.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/dropboxMenu.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SchoolSearchScreen extends StatelessWidget {
  SchoolSearchScreen({super.key});

  final UserInfoProvider _userInfoProvider = Get.put(UserInfoProvider());
  final SchoolSearchProvider _schoolSearchProvider =
      Get.put(SchoolSearchProvider());
  final SchoolsService _schoolService = SchoolsService();

  final TextEditingController _keywordController = TextEditingController();
  String _region = '';
  String _facility = '';

  bool _isSchoolSearchFormValidateCheck() {
    if (_keywordController.text.isEmpty ||
        _region.isEmpty ||
        _facility.isEmpty) {
      return false;
    }

    return true;
  }

  Widget _renderSearchResult(BuildContext context) {
    if (_schoolSearchProvider.searchedSchoolList.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: _schoolSearchProvider.searchedSchoolList.length,
        itemBuilder: (context, index) {
          SchoolsTable school = _schoolSearchProvider.searchedSchoolList[index];

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
                _userInfoProvider.setSelectedSchoolList(school);
                Get.back();
              },
            ),
          );
        },
      ),
    );
  }

  void _searchSchoolList() async {
    List<SchoolsTable> result = await _schoolService.getSchoolList(
        _region, _facility, _keywordController.text);

    _schoolSearchProvider.setSearchedSchoolList(result);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackGroundImageWidget(type: 'bg'),
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
          body: SingleChildScrollView(
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
                        onSelected: (v) {
                          _region = v;
                        },
                      ),
                      CustomDropBoxMenu(
                        label: SCHOOL_SEARCH_FACILITY_TYPE_TEXT,
                        items: FACILITY_CLASSIFICATION,
                        onSelected: (v) {
                          _facility = v;
                        },
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
                        controller: _keywordController,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black87,
                                ),
                        decoration: InputDecoration(
                          hintText: SCHOOL_SEARCH_SCHOOL_NAME_HINT_TEXT,
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(color: Colors.black87),
                          ),
                        ),
                        onPressed: () {
                          try {
                            if (!_isSchoolSearchFormValidateCheck()) {
                              throw Exception(SCHOOL_SEARCH_ERROR_TEXT);
                            }

                            _searchSchoolList();
                          } catch (e) {
                            CustomSnackbar.showDefaultErrorSnackbar(
                              title: 'エラー',
                              error: e,
                            );
                          }
                        },
                        child: const CustomTextWidget(
                          text: SCHOOL_SEARCH_SEARCH_BUTTON_TEXT,
                          kind: 'inputFieldTitle',
                        ),
                      ),
                      Obx(() => _renderSearchResult(context)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
