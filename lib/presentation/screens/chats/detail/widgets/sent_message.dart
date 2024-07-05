import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/chat_message.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.messageObject});
  final MessageObject messageObject;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.blue,
      child: Text(messageObject.content ?? ''),
    );
  }
}
