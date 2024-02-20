import 'dart:developer';

import 'package:find_friend/models/schools.dart';
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

class SchoolSearchScreen extends StatefulWidget {
  const SchoolSearchScreen({super.key});

  @override
  SchoolSearchState createState() => SchoolSearchState();
}

class SchoolSearchState extends State<SchoolSearchScreen> {
  final SchoolsService _schoolService = SchoolsService();
  final TextEditingController _keywordController = TextEditingController();
  final UserInfoProvider _userInfoProvider = Get.put(UserInfoProvider());

  String _prefecture = '';
  String _facility = '';
  final List<SchoolsTable> _searchSchoolList = [];

  Widget _renderSearchResult(BuildContext context) {
    if (_searchSchoolList.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: _searchSchoolList.length,
        itemBuilder: (context, index) {
          SchoolsTable school = _searchSchoolList[index];

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.school_outlined,
              ),
              title: CustomTextWidget(
                text: school.name ?? '',
                kind: 'inputFieldTitle',
              ),
              splashColor: Colors.indigo[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                _userInfoProvider.schools.add(school);
                Get.back();
              },
            ),
          );
        },
      ),
    );
  }

  void _getSearchSchoolList() async {
    List<SchoolsTable> result = await _schoolService.getSchoolList(
        _prefecture, _facility, _keywordController.text);

    _searchSchoolList.addAll(result);
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
                          _prefecture = v;
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
                  _renderSchoolAddButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _renderSchoolAddButton(BuildContext context) {
    return Column(
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
              if (_prefecture.isEmpty) {
                throw Exception(SCHOOL_SEARCH_PREFECTURE_ERROR);
              }

              if (_facility.isEmpty) {
                throw Exception(SCHOOL_SEARCH_FACILITY_TYPE_ERROR);
              }

              if (_keywordController.text.isEmpty) {
                throw Exception(SCHOOL_SEARCH_KEYWORD_ERROR);
              }
              Get.focusScope?.unfocus();
              _getSearchSchoolList();
            } catch (error) {
              CustomSnackbar.showErrorSnackbar(
                title: 'エラー',
                error: error,
              );
            }
          },
          child: const CustomTextWidget(
            text: SCHOOL_SEARCH_SEARCH_BUTTON_TEXT,
            kind: 'inputFieldTitle',
          ),
        ),
        _renderSearchResult(context),
      ],
    );
  }
}
