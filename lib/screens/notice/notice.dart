import 'dart:developer';

import 'package:find_friend/providers/notice.dart';
import 'package:find_friend/screens/notice/noticeDetail.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  NoticeScreenState createState() => NoticeScreenState();
}

class NoticeScreenState extends State<NoticeScreen> {
  final NoticeProvider noticeProvider = Get.put(NoticeProvider());

  @override
  void initState() {
    log('initState', name: 'NoticeScreen');
    super.initState();
    noticeProvider.initNoticeList();
  }

  @override
  void dispose() {
    log('dispose', name: 'NoticeScreen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
            : ListView.builder(
                itemCount: noticeProvider.notices.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 10.0, right: 10),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      child: newMethod(index),
                    ),
                  );
                },
              ),
      ),
    );
  }

  ListTile newMethod(int index) {
    return ListTile(
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
            transition: Transition.size,
            arguments: noticeProvider.notices[index]);
      },
    );
  }
}
