import 'package:find_friend/providers/notice.dart';
import 'package:find_friend/screens/notice/noticeDetail.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeScreen extends StatelessWidget {
  NoticeScreen({super.key});

  final NoticeProvider noticeProvider = Get.put(NoticeProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const CustomTextWidget(
          text: 'お知らせ',
          kind: 'headTitle',
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => noticeProvider.notices.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _renderContents(),
      ),
    );
  }

  ListView _renderContents() {
    return ListView.builder(
      itemCount: noticeProvider.notices.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                color: Colors.black54,
              ),
            ),
            title: CustomTextWidget(
              text: noticeProvider.notices[index].data['title'],
              kind: 'listTitle',
            ),
            leading: const Icon(
              Icons.notifications_none,
              color: Colors.black54,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
            onTap: () {
              Get.to(() => const NoticeDetailScreen(),
                  transition: Transition.rightToLeft,
                  arguments: noticeProvider.notices[index]);
            },
          ),
        );
      },
    );
  }
}
