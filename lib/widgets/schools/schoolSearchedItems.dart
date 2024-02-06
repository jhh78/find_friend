import 'package:find_friend/models/schools.dart';
import 'package:find_friend/screens/schoolSearch/schoolSearch.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/widgets/common/error.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/schools/selectedSchoolList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchedItemsWidget extends StatelessWidget {
  final bool isProcessing;
  final String? validate;
  final List<SchoolsTable> schools;

  const SchoolSearchedItemsWidget({
    super.key,
    required this.isProcessing,
    this.validate,
    required this.schools,
  });

  @override
  Widget build(BuildContext context) {
    if (isProcessing) {
      Container();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextWidget(
                text: '学校選択',
                kind: 'inputFieldTitle',
              ),
              IconButton(
                icon: const Icon(Icons.add_box_outlined),
                color: Colors.blueAccent,
                onPressed: () {
                  Get.to(
                    () => SchoolSearchScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ],
          ),
          if (validate != null)
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: CustomErrorWidget(
                errorText: SCHOOL_SEARCH_ERROR,
              ),
            ),
          SelectedSchoolListWidget(
            list: schools,
          ),
        ],
      ),
    );
  }
}
