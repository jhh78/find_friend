import 'dart:developer';

import 'package:find_friend/models/message.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/message.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:get/get.dart';

class MessageProvider extends GetxController {
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final MessageService messageService = MessageService();
  final SystemService systemService = SystemService();

  RxInt currentPage = 1.obs;
  RxList<MessageTable> messageList = <MessageTable>[].obs;

  @override
  void onInit() {
    super.onInit();
    log('MessageProvider onInit called', name: 'MessageProvider');
    systemService.getAuthKey().then((value) async {
      log('MessageProvider onInit called $value', name: 'MessageProvider');

      List<MessageTable> list =
          await messageService.getMessageList(value, 1, PAGE_PER_ITEM);

      messageList.addAll(list);
    });
  }

  @override
  void onClose() {
    super.onClose();
    log('MessageProvider onClose called');
  }
}
