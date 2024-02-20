import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/screens/schoolSearch/schoolSearch.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchedItemsWidget extends StatelessWidget {
  final bool isRequired;
  final UserInfoProvider _userInfoProvider = Get.put(UserInfoProvider());

  SchoolSearchedItemsWidget({
    super.key,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CustomTextWidget(
                    text: '学校選択',
                    kind: 'inputFieldTitle',
                  ),
                  if (isRequired)
                    const CustomTextWidget(
                      text: ' *必須',
                      kind: 'error',
                    ),
                ],
              ),
              Obx(
                () => _userInfoProvider.schools.length < 2
                    ? IconButton(
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        color: Colors.blueAccent,
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.blue[200]),
                        ),
                        onPressed: () {
                          Get.to(
                            () => const SchoolSearchScreen(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      )
                    : Container(),
              ),
            ],
          ),
          Obx(
            () => Column(
              children: _userInfoProvider.schools.map(
                (school) {
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
                        _userInfoProvider.schools.remove(school);
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}
