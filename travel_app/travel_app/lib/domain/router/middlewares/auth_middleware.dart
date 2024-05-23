import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/data_controller/auth_controller.dart';
import '../route.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthController _authController = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    RouteSettings? result;
    if (_authController.getAuthUser == null) {
      // TODO(ALL): update navigation route
      result = const RouteSettings(name: AppRouter.uiTest);
    }
    return result;
  }
}
