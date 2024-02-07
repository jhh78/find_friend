import 'package:find_friend/models/schools.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/schoolSearch/schoolSearch.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchedItemsWidget extends StatelessWidget {
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());

  SchoolSearchedItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          Obx(
            () => Column(
              children: userInfoProvider.selectedSchoolList
                  .map((SchoolsTable school) {
                debugPrint('学校名: ${school.name}');
                return ListTile(
                  title: CustomTextWidget(
                    text: school.name.toString(),
                    kind: 'titleMedium',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    onPressed: () {
                      userInfoProvider.selectedSchoolList.remove(school);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
