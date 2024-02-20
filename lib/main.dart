import 'package:find_friend/providers/appData.dart';
import 'package:find_friend/screens/intro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AppDataProvider());
    return GetMaterialApp(
      title: '友達を探す',
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: IntroScreen(),
    );
  }
}
