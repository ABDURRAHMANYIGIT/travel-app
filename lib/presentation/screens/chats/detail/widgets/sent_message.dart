import 'package:flutter/material.dart';

import '../../../../../data/models/chat_message.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.messageObject});
  final MessageObject messageObject;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text(messageObject.content ?? ''),
    );
  }
}
