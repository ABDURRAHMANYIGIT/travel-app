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
  final ChatsDataController chatsDataController = Get.find();
  final int targetChatId;
  final int targetUserId;
  final Rxn<UserObject> _targetUser = Rxn();
  UserObject? get targetUser => _targetUser.value;
  final RxList<MessageObject> _messages = RxList([]);
  List<MessageObject> get messages => _messages;

  @override
  void onInit() async {
    _targetUser.value =
        await _databaseServices.getOtherUser(userId: targetUserId);
    _messages.value =
        await _databaseServices.getChatMessages(chatId: targetChatId);

    super.onInit();
  }

  Future<bool> sendMessage() async {
    return chatsDataController.sendMessage(
        message: messageEditingController.text, receiverId: targetUserId);
  }
}
