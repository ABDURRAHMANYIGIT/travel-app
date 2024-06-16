import 'package:get/get.dart';

import '../data_controller/chats_data_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatsDataController>(ChatsDataController(), permanent: true);
  }
}
