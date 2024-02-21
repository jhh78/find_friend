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
    initMassageList();
  }

  @override
  void onClose() {
    super.onClose();
    log('MessageProvider onClose called');
  }

  Future<void> initMassageList() async {
    log('initMassageList called', name: 'MessageProvider');
    messageList.clear();
    currentPage.value = 1;
    List<MessageTable> list = await _searchMessageList();
    messageList.addAll(list);
  }

  Future<void> getNextPageMessages() async {
    log('getNextPageMessages called', name: 'MessageProvider');
    currentPage.value++;
    List<MessageTable> list = await _searchMessageList();
    messageList.addAll(list);
  }

  Future<List<MessageTable>> _searchMessageList() async {
    log('_searchMessageList called', name: 'MessageProvider');
    String uuid = await systemService.getAuthKey();
    List<MessageTable> list = await messageService.getMessageList(
        uuid, currentPage.value, PAGE_PER_ITEM);
    return list;
  }
}
