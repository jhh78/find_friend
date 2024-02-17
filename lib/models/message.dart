import 'package:find_friend/models/user.dart';

class MessageTable {
  late String id;
  late UsersTable fromUser;
  late UsersTable toUser;
  late String message;
  late String oriMessage;
  late String created;

  MessageTable({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.message,
    required this.oriMessage,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from_user': fromUser,
      'to_user': toUser,
      'message': message,
      'ori_message': oriMessage,
      'created': created,
    };
  }

  MessageTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUser = json['from_user'];
    toUser = json['to_user'];
    message = json['message'];
    oriMessage = json['ori_message'];
    created = json['created'];
  }
}
