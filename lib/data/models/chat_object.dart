import 'dart:developer';

import 'chat_message.dart';

class ChatObject {
  ChatObject();

  ChatObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      userOneId = json['user_one_id'] as int?;
      userTwoId = json['user_two_id'] as int?;
      lastMessage = json['last_message'] as MessageObject?;
    } catch (e) {
      log(e.toString());
    }
  }

  int? id;
  int? userOneId;
  int? userTwoId;
  MessageObject? lastMessage;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_one_id': userOneId,
      'user_two_id': userTwoId,
      'last_message': lastMessage,
    };
  }
}
