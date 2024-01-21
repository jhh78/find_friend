import 'package:find_friend/providers/app_data.dart';
import 'package:find_friend/screens/notice/notice.dart';
import 'package:find_friend/screens/support/support.dart';
import 'package:find_friend/screens/thread/thread.dart';
import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreen extends GetView<AppDataController> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        AppDataController.to.initNavigatorPops();
      },
      child: SafeArea(
        child: Obx(
          () => Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg2.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: IndexedStack(
                index: controller.navibarCurrentIndex.value,
                children: [
                  Navigator(
                    key: AppDataController.to.threadNavigatorKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => const ThreadScreen(),
                    ),
                  ),
                  Navigator(
                    key: AppDataController.to.noticeNavigatorKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => const NoticeScreen(),
                    ),
                  ),
                  const SupportScreen(),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.navibarCurrentIndex.value,
              selectedItemColor: COLOR_MAP['naviSelected'],
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                AppDataController.to.initNavigatorPops();
                controller.changeNaviBarCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted),
                  label: THREAD_LIST_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: NOTICE_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: DEVELOPER_DONATION_BUTTON_TEXT,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
