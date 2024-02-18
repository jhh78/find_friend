import 'package:find_friend/models/threadContents.dart';
import 'package:find_friend/providers/threadContents.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/thread/contsnts/card.dart';
import 'package:find_friend/widgets/thread/contsnts/messageForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadContentsListWidget extends StatelessWidget {
  ThreadContentsListWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final ThreadContentsProvider threadContentsProvider =
      Get.put(ThreadContentsProvider());

  @override
  Widget build(BuildContext context) {
    Widget renderMessageList(BuildContext context) => ListView.builder(
          itemCount: threadContentsProvider.threadContentsList.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            ThreadContentsTable item =
                threadContentsProvider.threadContentsList[index];

            // return Container(
            //   margin: const EdgeInsets.all(8.0),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(8.0),
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Colors.black12,
            //         blurRadius: 5.0,
            //         spreadRadius: 2.0,
            //         offset: Offset(2.0, 2.0),
            //       ),
            //     ],
            //   ),
            //   child: ThreadItemCardWidget(
            //     isOwner: item.userId == userInfoProvider.userId.value,
            //     item: item,
            //   ),
            // );
          },
        );

    Widget renderNoMessage() {
      return const Center(
        child: CustomTextWidget(
          text: 'スレットがありません。',
          kind: 'label',
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Obx(
            () => threadContentsProvider.threadContentsList.isEmpty
                ? renderNoMessage()
                : renderMessageList(context),
          ),
        ),
        const Divider(height: 1.0),
        ThreadContentsMessageFormWidget(
          scrollController: scrollController,
        ),
      ],
    );
  }
}
