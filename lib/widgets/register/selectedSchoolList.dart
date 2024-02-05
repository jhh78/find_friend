import 'package:find_friend/models/schools.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedSchoolListWidget extends StatelessWidget {
  final List<SchoolsTable> list;

  const SelectedSchoolListWidget({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: list.map((SchoolsTable school) {
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
                list.remove(school);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
