class ChatMessage {
  const ChatMessage({
    this.id,
    required this.idFrom,
    required this.idTo,
    required this.content,
    this.isDeletedBy,
  });
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      idFrom: json['id_from'] as String,
      idTo: json['id_to'] as String,
      content: json['content'] as String,
      isDeletedBy: json['isDeletedBy'] as List<String>?,
    );
  }

  final String? id;
  final String idFrom;
  final String idTo;
  final String content;
  final List<String>? isDeletedBy;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id_from': idFrom,
      'id_to': idTo,
      'content': content,
      'isDeletedBy': isDeletedBy ?? <String>[],
    };
  }

  ChatMessage copyWith(
      {final String? id,
      final String? idFrom,
      final String? idTo,
      final String? content,
      final DateTime? timeStamp,
      final DateTime? readTimestamp,
      final List<String>? isDeletedBy}) {
    return ChatMessage(
      id: id ?? this.id,
      idFrom: idFrom ?? this.idFrom,
      idTo: idTo ?? this.idTo,
      content: content ?? this.content,
      isDeletedBy: isDeletedBy ?? this.isDeletedBy,
    );
  }
}
