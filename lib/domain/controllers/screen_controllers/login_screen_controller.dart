import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/index.dart';
import '../../router/route.dart';
import '../data_controller/auth_controller.dart';

class LoginScreenController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final AuthController _authController = Get.find();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  Future<bool> login() async {
    final result = await _databaseServices.login(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text);

    _authController.getUser();

    if (result) {
      Get.toNamed(AppRouter.designRoute);
    }

    return result;
  }
}
