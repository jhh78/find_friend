import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/screens/register/school_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchField extends StatelessWidget {
  const SchoolSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              Get.dialog(
                const SchoolSearchScreen(),
                barrierDismissible: false,
              );
            },
            child: Text(
              REGISTER_GRADUATED_SCHOOL_ADD_TITLE,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.yellow[100],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
