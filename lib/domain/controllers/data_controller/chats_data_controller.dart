import 'package:get/get.dart';

import '../../../data/models/chat_object.dart';
import '../../repositories/index.dart';

class ChatsDataController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final RxList<ChatObject> _chats = RxList.empty();
  List<ChatObject> get chats => _chats;

  @override
  void onInit() async {
    await getChats();
    super.onInit();
  }

  Future<void> getChats() async {
    _chats.value = await _databaseServices.getAllChats();
    update();
  }

  Future<ChatObject?> createNewChat(
      {required int userOneId, required int userTwoId}) async {
    final newChat = await _databaseServices.createNewChat(
        userOneId: userOneId, userTwoId: userTwoId);
    await getChats();
    update();
    return newChat;
  }
}
