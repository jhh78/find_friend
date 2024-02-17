import 'dart:developer';

import 'package:find_friend/models/message.dart';
import 'package:find_friend/providers/userInfo.dart';
import 'package:find_friend/services/message.dart';
import 'package:find_friend/services/system.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageProvider extends GetxController {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final UserInfoProvider userInfoProvider = Get.put(UserInfoProvider());
  final MessageService messageService = MessageService();

  RxInt currentPage = 1.obs;
  RxList<MessageTable> messageList = <MessageTable>[].obs;

  @override
  void onInit() {
    super.onInit();
    log('MessageProvider onInit called');
    SystemService().getAuthKey().then((value) async {
      log('MessageProvider onInit called $value');

      List<MessageTable> list = await messageService.getMessageList(
          value.toString(), 1, PAGE_PER_ITEM);

      messageList.addAll(list);
    });
  }

  @override
  void onClose() {
    super.onClose();
    log('MessageProvider onClose called');
  }
}
