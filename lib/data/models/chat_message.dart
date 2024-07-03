import 'dart:developer';

class MessageObject {
  MessageObject();

  MessageObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      chatId = json['chat_id'] as int?;
      idFrom = json['sender_id'] as int?;
      idTo = json['receiver_id'] as int?;
      content = json['content'] as String?;
    } catch (e) {
      log(e.toString());
    }
  }

  int? idFrom;
  int? id;
  int? chatId;
  int? idTo;
  String? content;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender_id': idFrom,
      'receiver_id': idTo,
      'content': content,
    };
  }
}
