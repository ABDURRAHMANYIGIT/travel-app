import 'package:get/get.dart';

import '../../../data/models/user_object.dart';
import '../../repositories/index.dart';
import '../../router/route.dart';
import '../data_controller/auth_controller.dart';
import '../data_controller/chats_data_controller.dart';

class UsersScreenController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final AuthController _authController = Get.find();
  final ChatsDataController _chatsDataController = Get.find();
  final RxList<UserObject> _users = RxList([]);
  List<UserObject?> get users => _users;

  @override
  void onInit() async {
    _users.value = await _databaseServices.getAllUsers();
    super.onInit();
  }

  Future<void> onTapSendMessage(int userId) async {
    var existingChat = _chatsDataController.chats.firstWhereOrNull(
        (chat) => (chat.userTwoId == userId) || (chat.userOneId == userId));

    existingChat ??= await _chatsDataController.createNewChat(
        userOneId: _authController.getAuthUser!.id!, userTwoId: userId);

    return Get.toNamed(AppRouter.chatDetailRoute, parameters: {
      'chatId': existingChat!.id.toString(),
      'userId': userId.toString()
    });
  }
}
