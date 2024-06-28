import 'package:flutter/material.dart';

import '../../../../../data/models/chat_message.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.messageObject});
  final MessageObject messageObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Text(messageObject.content ?? ''),
    );
  }
}
