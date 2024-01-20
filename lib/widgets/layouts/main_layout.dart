import 'package:find_friend/utils/colors.dart';
import 'package:find_friend/utils/message/common.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: child),
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: COLOR_MAP['naviSelected'],
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                debugPrint('index: $index');
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.manage_accounts),
                  label: HOME_BUTTON_TEXT,
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
            )),
      ),
    );
  }
}
