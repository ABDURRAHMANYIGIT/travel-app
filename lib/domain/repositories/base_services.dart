import '../../data/models/chat_message.dart';
import '../../data/models/chat_object.dart';
import '../../data/models/user_object.dart';

abstract class BaseServices {
  Future<int> getExample();
  Future<UserObject?> getUser();
  Future<UserObject?> getOtherUser({required int userId});
  Future<bool> login({required String email, required String password});
  Future<List<UserObject>> getAllUsers();
  Future<List<ChatObject>> getAllChats();
  Future<ChatObject?> createNewChat(
      {required int userOneId, required int userTwoId});
  Future<List<MessageObject>> getChatMessages({required int chatId, int? page});
}
