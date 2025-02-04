import 'package:find_friend/providers/appData.dart';
import 'package:find_friend/screens/favorite/favorite.dart';
import 'package:find_friend/screens/message/message.dart';
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

  Widget _renderContentWidget() {
    if (controller.navibarCurrentIndex.value == 0) {
      return const UserInfoScreen();
    } else if (controller.navibarCurrentIndex.value == 1) {
      return const ThreadScreen();
    } else if (controller.navibarCurrentIndex.value == 2) {
      return const FavoriteScreen();
    } else if (controller.navibarCurrentIndex.value == 3) {
      return const MessageScreen();
    } else if (controller.navibarCurrentIndex.value == 4) {
      return const NoticeScreen();
    } else if (controller.navibarCurrentIndex.value == 5) {
      return const SupportScreen();
    }

    return const Placeholder();
  }

  Widget _renderBottomNavigaterIcons(IconData icon, bool isNotice) {
    if (!isNotice) {
      return Icon(icon);
    }

    return Stack(
      children: <Widget>[
        Icon(icon),
        Positioned(
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 10,
              minHeight: 10,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Obx(
        () => Scaffold(
          body: Stack(
            children: [
              const CustomBackGroundImageWidget(
                type: 'bg',
              ),
              _renderContentWidget(),
            ],
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              canvasColor: Colors.black87,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.red,
              currentIndex: controller.navibarCurrentIndex.value,
              type: BottomNavigationBarType.shifting,
              unselectedItemColor: Colors.blueGrey,
              selectedItemColor: Colors.amber,
              onTap: (int index) {
                controller.changeNaviBarCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon:
                      _renderBottomNavigaterIcons(Icons.person_outline, false),
                  label: HOME_BASIC_INFO_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon: _renderBottomNavigaterIcons(
                      Icons.format_list_bulleted, false),
                  label: THREAD_LIST_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon: _renderBottomNavigaterIcons(Icons.star, false),
                  label: FAVORITE_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon: _renderBottomNavigaterIcons(Icons.mail_outline, false),
                  label: MESSAGE_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon: _renderBottomNavigaterIcons(Icons.info_outline, false),
                  label: NOTICE_BUTTON_TEXT,
                ),
                BottomNavigationBarItem(
                  icon:
                      _renderBottomNavigaterIcons(Icons.favorite_border, false),
                  label: DEVELOPER_DONATION_BUTTON_TEXT,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
