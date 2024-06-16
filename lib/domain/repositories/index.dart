import '../../data/models/chat_message.dart';
import '../../data/models/chat_object.dart';
import '../../data/models/user_object.dart';
import '../../data/repositories/api.dart';
import 'base_services.dart';

class DatabaseServices implements BaseServices {
  factory DatabaseServices() => _instance;
  DatabaseServices._internal();
  static final DatabaseServices _instance = DatabaseServices._internal();
  BaseServices api = API();

  @override
  Future<int> getExample() {
    return api.getExample();
  }

  @override
  Future<UserObject?> getUser() async {
    return api.getUser();
  }

  @override
  Future<bool> login({required String email, required String password}) {
    return api.login(email: email, password: password);
  }

  @override
  Future<List<UserObject>> getAllUsers() {
    return api.getAllUsers();
  }

  @override
  Future<List<ChatObject>> getAllChats() {
    return api.getAllChats();
  }

  @override
  Future<ChatObject?> createNewChat(
      {required int userOneId, required int userTwoId}) {
    return api.createNewChat(userOneId: userOneId, userTwoId: userTwoId);
  }

  @override
  Future<UserObject?> getOtherUser({required int userId}) {
    return api.getOtherUser(userId: userId);
  }

  @override
  Future<List<MessageObject>> getChatMessages(
      {required int chatId, int? page}) {
    return api.getChatMessages(chatId: chatId, page: page);
  }
}
