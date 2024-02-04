import 'package:find_friend/providers/register.dart';
import 'package:find_friend/utils/message/register.dart';
import 'package:find_friend/screens/register/school_search_screen.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSearchField extends GetView<RegisterController> {
  const SchoolSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Obx(
      () => controller.isProcessing.value
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: controller.isProcessing.value
                          ? Colors.grey
                          : Colors.blue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.isProcessing.value
                        ? null
                        : () {
                            debugPrint('検索ボタンが押されました');
                            Get.dialog(
                              const SchoolSearchScreen(),
                              barrierDismissible: false,
                            );
                          },
                    child: const CustomTextWidget(
                      text: REGISTER_GRADUATED_SCHOOL_ADD_TITLE,
                      kind: 'button',
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
