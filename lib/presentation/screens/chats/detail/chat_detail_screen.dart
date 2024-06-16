import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums/appbar_type_enum.dart';
import '../../../../domain/controllers/screen_controllers/chat_detail_screen_controller.dart';
import '../../../global_components/appbar/appbar_widget.dart';
import '../../../layouts/main_layout.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatDetailScreenController chatDetailScreenController = Get.put(
        ChatDetailScreenController(
            targetChatId: int.parse(Get.parameters['chatId']!),
            targetUserId: int.parse(Get.parameters['userId']!)));
    return MainLayout(
      appBar: CustomAppBar(
        appbarType: AppbarType.withTitle,
        title: chatDetailScreenController.targetUser?.name ?? '',
      ),
      content: Column(
        children: [],
      ),
    );
  }
}
