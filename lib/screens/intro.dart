import 'package:find_friend/screens/register/register.dart';
import 'package:find_friend/widgets/common/backgroud_image.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('IntroScreen tapped');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
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
