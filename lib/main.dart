import 'package:find_friend/screens/register/register.dart';
import 'package:find_friend/screens/root.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final SystemService _systemService = SystemService();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Find Friend',
      home: UpgradeAlert(
        child: Scaffold(
          body: InkWell(
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
          ),
        ),
      ),
    );
  }
}
