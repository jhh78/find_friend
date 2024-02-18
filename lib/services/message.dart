import 'dart:developer';

import 'package:find_friend/models/message.dart';
import 'package:find_friend/models/user.dart';
import 'package:find_friend/models/userBan.dart';
import 'package:find_friend/services/threadContents.dart';
import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class MessageService {
  Future<List<MessageTable>> getMessageList(
      String userId, int currentPage, int perPage) async {
    try {
      log('getMessageList called > $userId', name: 'getMessageList');
      // final pb = PocketBase(API_URL);
      // final response = await pb.collection('message').getList(
      //       page: currentPage,
      //       perPage: perPage,
      //       expand: 'to_user, from_user',
      //       filter: 'to_user="$userId"',
      //       sort: '-created',
      //     );

      // List<MessageTable> messageList = [];

      // for (RecordModel item in response.items) {
      //   Map<String, dynamic> params = {
      //     'id': item.id,
      //     'created': item.created,
      //     'from_user': UsersTable.fromjson({
      //       "id": item.expand['from_user']?.first.id,
      //       ...item.expand['from_user']?.first.data ?? {},
      //     }),
      //     'to_user': UsersTable.fromjson({
      //       "id": item.expand['to_user']?.first.id,
      //       ...item.expand['to_user']?.first.data ?? {},
      //     }),
      //     'message': item.data['message'],
      //     'ori_message': item.data['ori_message'],
      //   };

      //   messageList.add(MessageTable.fromJson(params));
      // }

      // return messageList;
      return [];
    } catch (error) {
      rethrow;
    }
  }

  Future sendMessage(
      String fromUser, String toUser, String message, String oriMessage) async {
    try {
      final ThreadContentsService threadContentsService =
          ThreadContentsService();
      await threadContentsService.sendMessage(
          fromUser, toUser, message, oriMessage);
    } catch (error) {
      rethrow;
    }
  }

  Future deleteMessage(String messageId) async {
    try {
      final pb = PocketBase(API_URL);
      await pb.collection('message').delete(messageId);
    } catch (error) {
      rethrow;
    }
  }
}
