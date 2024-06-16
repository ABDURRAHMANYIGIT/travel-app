import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/screen_controllers/login_screen_controller.dart';
import '../../global_components/custom_widgets/custom_button.dart';
import '../../global_components/custom_widgets/customtext_form_field.dart';
import '../../layouts/main_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginScreenController loginScreenController =
        Get.put(LoginScreenController());
    return MainLayout(
      content: Form(
          child: Column(
        children: [
          CustomTextFormField(
              controller: loginScreenController.emailTextEditingController),
          CustomTextFormField(
              controller: loginScreenController.passwordTextEditingController),
          CustomButton(
            child: Text('login'),
            buttonName: 'login button',
            onTap: () => loginScreenController.login(),
          )
        ],
      )),
    );
  }
}
