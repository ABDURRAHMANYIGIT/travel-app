import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums/accommodation_detail_tab_enum.dart';
import '../../../../domain/controllers/screen_controllers/accommodation_screen_controller.dart';
import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/custom_widgets/custom_button.dart';
import '../../../global_components/texts/custom_text.dart';

class AccommodationDetailTabs extends StatelessWidget {
  const AccommodationDetailTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final AccommodationScreenController screenController = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        AccommodationDetailTabEnum.values.length,
        (index) {
          final e = AccommodationDetailTabEnum.values[index];
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  right: index == AccommodationDetailTabEnum.values.length - 1
                      ? 0.0
                      : 8.0),
              child: Obx(
                () {
                  return CustomButton(
                    onTap: () => screenController.selectTab(e),
                    color: screenController.selectedTab == e
                        ? Colors.blueAccent
                        : Colors.white30,
                    buttonName: 'Detail Page Tab Button',
                    child: CustomText(
                      e.getTitle,
                      style: AppTextStyle.bodyLarge(
                          color: screenController.selectedTab == e
                              ? AppColors.white
                              : AppColors.black),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
