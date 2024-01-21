import 'package:find_friend/providers/app_data.dart';
import 'package:find_friend/screens/intro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AppDataController());
    return GetMaterialApp(
      title: '友達を探す',
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const SafeArea(
        child: IntroScreen(),
      ),
    );
  }
}
