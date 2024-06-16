import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/screen_controllers/users_screen_controller.dart';
import '../../global_components/custom_widgets/custom_button.dart';
import '../../layouts/main_layout.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersScreenController usersScreenController =
        Get.put(UsersScreenController());
    return MainLayout(
      content: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              ...usersScreenController.users.map((user) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(user?.name ?? ''),
                      CustomButton(
                          child: Text('Go to messages'),
                          buttonName: 'buttonName',
                          onTap: () =>
                              usersScreenController.onTapSendMessage(user!.id!))
                    ],
                  ))
            ],
          );
        }),
      ),
    );
  }
}
