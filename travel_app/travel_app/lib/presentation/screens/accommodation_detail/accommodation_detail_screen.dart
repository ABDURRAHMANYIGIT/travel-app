import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/screen_controllers/accommodation_detail_screen_controller.dart';
import '../../../resources/styles/colors.dart';
import '../../../resources/styles/text_styles.dart';
import '../../global_components/texts/custom_text.dart';
import '../../layouts/main_layout.dart';

class AccommodationDetailScreen extends StatelessWidget {
  const AccommodationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccommodationDetailScreenController screenController = Get.put(
        AccommodationDetailScreenController(int.parse(Get.parameters['id']!)));
    return Obx(() {
      return MainLayout(
        content: CustomText(
          screenController.accommodationObject?.name ?? '',
          style: AppTextStyle.h5(color: AppColors.black),
        ),
      );
    });
  }
}
