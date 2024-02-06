import 'package:find_friend/providers/appData.dart';
import 'package:find_friend/screens/notice/notice.dart';
import 'package:find_friend/screens/support/support.dart';
import 'package:find_friend/screens/thread/thread.dart';
import 'package:find_friend/screens/userInfo/userInfo.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  final AppDataProvider controller = Get.put(AppDataProvider());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        AppDataProvider.to.initNavigatorPops();
      },
      child: SafeArea(
        child: Obx(
          () => Scaffold(
            body: Stack(
              children: [
                const CustomBackGroundImageWidget(
                  type: 'bg2',
                ),
                IndexedStack(
                  index: controller.navibarCurrentIndex.value,
                  children: [
                    Navigator(
                      key: AppDataProvider.to.userInfoNavigatorKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const UserInfo(),
                      ),
                    ),
                    Navigator(
                      key: AppDataProvider.to.threadNavigatorKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const ThreadScreen(),
                      ),
                    ),
                    Navigator(
                      key: AppDataProvider.to.noticeNavigatorKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => const NoticeScreen(),
                      ),
                    ),
                    const SupportScreen(),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.navibarCurrentIndex.value,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                AppDataProvider.to.initNavigatorPops();
                controller.changeNaviBarCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: HOME_BASIC_INFO_BUTTON_TEXT,
                ),
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
