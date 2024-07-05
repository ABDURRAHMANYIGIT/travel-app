import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/chat_message.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.messageObject});
  final MessageObject messageObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey,
      child: Text(messageObject.content ?? ''),
    );
  }
}
