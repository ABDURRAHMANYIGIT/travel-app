import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../data/models/chat_message.dart';
import '../../../data/models/user_object.dart';
import '../../repositories/index.dart';
import '../data_controller/chats_data_controller.dart';

class ChatDetailScreenController extends GetxController {
  ChatDetailScreenController(
      {required this.targetChatId, required this.targetUserId});
  final TextEditingController messageEditingController =
      TextEditingController();
  final DatabaseServices _databaseServices = DatabaseServices();
  final ChatsDataController _chatsDataController = Get.find();
  final int targetChatId;
  final int targetUserId;
  final Rxn<UserObject> _targetUser = Rxn();
  UserObject? get targetUser => _targetUser.value;
  List<MessageObject> get messages {
    final chatEntry =
        _chatsDataController.messagesPairedWithChats.firstWhereOrNull(
      (entry) => entry['chat'].id == targetChatId,
    );

    if (chatEntry == null) {
      return []; // Return an empty list or handle this case based on your application logic
    }

    return (chatEntry['messages'] as List).cast<MessageObject>();
  }

  @override
  void onInit() async {
    _targetUser.value =
        await _databaseServices.getOtherUser(userId: targetUserId);

    super.onInit();
  }

  Future<bool> sendMessage() async {
    return _chatsDataController.sendMessage(
        message: messageEditingController.text, receiverId: targetUserId);
  }
}
