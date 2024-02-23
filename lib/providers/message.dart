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

  Future<void> initMassageList() async {
    try {
      log('initMassageList called', name: 'MessageProvider');
      messageList.clear();
      currentPage.value = 1;
      List<MessageTable> list = await _searchMessageList();
      messageList.addAll(list);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getNextPageMessages() async {
    try {
      log('getNextPageMessages called', name: 'MessageProvider');
      currentPage.value++;
      List<MessageTable> list = await _searchMessageList();
      messageList.addAll(list);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<MessageTable>> _searchMessageList() async {
    try {
      log('_searchMessageList called', name: 'MessageProvider');
      String userId = userInfoProvider.id.value;
      List<MessageTable> list = await messageService.getMessageList(
          userId, currentPage.value, PAGE_PER_ITEM);
      return list;
    } catch (error) {
      rethrow;
    }
  }
}
