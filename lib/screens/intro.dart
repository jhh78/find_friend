import 'package:find_friend/models/system.dart';
import 'package:find_friend/screens/register/register.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<SystemTable> record = await SystemService().getItem('key');

        debugPrint('record: $record');
        if (record.isNotEmpty) {
          Get.to(() => RootScreen());
        } else {
          Get.to(() => RegisterScreen());
        }
      },
      child: const Stack(
        children: [
          CustomBackGroundImageWidget(
            type: 'intro',
          ),
        ],
      ),
    );
  }
}
