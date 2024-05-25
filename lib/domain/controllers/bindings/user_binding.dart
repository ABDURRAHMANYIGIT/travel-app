import 'package:get/get.dart';

import '../data_controller/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController(), permanent: true);
  }
}
