import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/index.dart';
import '../../router/route.dart';

class LoginScreenController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  Future<bool> login() async {
    final result = await _databaseServices.login(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text);

    if (result) {
      Get.toNamed(AppRouter.designRoute);
    }

    return result;
  }
}
