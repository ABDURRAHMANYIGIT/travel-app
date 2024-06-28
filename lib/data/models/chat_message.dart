import 'dart:developer';

class MessageObject {
  MessageObject();

  MessageObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as String?;
      idFrom = json['sender_id'] as String?;
      idTo = json['receiver_id'] as String?;
      content = json['content'] as String?;
    } catch (e) {
      log(e.toString());
    }
  }

  String? idFrom;
  String? id;
  String? idTo;
  String? content;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender_id': idFrom,
      'receiver_id': idTo,
      'content': content,
    };
  }
}
