import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums/appbar_type_enum.dart';
import '../../../../domain/controllers/screen_controllers/chat_detail_screen_controller.dart';
import '../../../global_components/appbar/appbar_widget.dart';
import '../../../global_components/custom_widgets/custom_button.dart';
import '../../../global_components/custom_widgets/customtext_form_field.dart';
import '../../../layouts/main_layout.dart';
import 'widgets/receive_message.dart';
import 'widgets/sent_message.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatDetailScreenController chatDetailScreenController = Get.put(
        ChatDetailScreenController(
            targetChatId: int.parse(Get.parameters['chatId']!),
            targetUserId: int.parse(Get.parameters['userId']!)));
    return MainLayout(
      bottomSheet: SizedBox(
        height: kBottomNavigationBarHeight * 3,
        child: Column(
          children: [
            CustomTextFormField(
                controller:
                    chatDetailScreenController.messageEditingController),
            CustomButton(
                onTap: chatDetailScreenController.sendMessage,
                child: Text('send message'),
                buttonName: 'send message button')
          ],
        ),
      ),
      appBar: CustomAppBar(
        appbarType: AppbarType.withTitle,
        title: chatDetailScreenController.targetUser?.name ?? '',
      ),
      content: Obx(() {
        return Column(
          children: [
            chatDetailScreenController.messages.isNotEmpty
                ? Container(
                    color: Colors.amber,
                    height: Get.height * 0.7,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: chatDetailScreenController
                          .messages.length, // Ensure you have the itemCount
                      itemBuilder: (BuildContext ctx, int index) {
                        final element =
                            chatDetailScreenController.messages[index];
                        if (element.idFrom ==
                            chatDetailScreenController.targetUser?.id
                                .toString()) {
                          return ReceivedMessage(
                            messageObject: element,
                          );
                        } else {
                          return SentMessage(messageObject: element);
                        }
                      },
                    ),
                  )
                : Text('no message yet'),
          ],
        );
      }),
    );
  }
}
