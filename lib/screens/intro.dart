import 'package:find_friend/screens/register/register.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});
  final SystemService _systemService = SystemService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var uuid = await _systemService.getAuthKey();

        if (uuid.isNotEmpty) {
          Get.offAll(
            () => RootScreen(),
            transition: Transition.fadeIn,
          );
        } else {
          Get.offAll(
            () => RegisterScreen(),
            transition: Transition.rightToLeft,
          );
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
