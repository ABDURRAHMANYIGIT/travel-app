import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/enums/accommodation_detail_tab_enum.dart';
import '../../../../data/models/accommodation.dart';
import '../../../../domain/controllers/screen_controllers/accommodation_screen_controller.dart';
import '../../../../resources/styles/colors.dart';
import 'name_and_rating.dart';
import 'tab_contents/about_tab_content.dart';
import 'tab_contents/gallery_tab_content.dart';
import 'tab_contents/reviews_tab_content.dart';
import 'tabs.dart';

class AccommodationDetailContent extends StatelessWidget {
  const AccommodationDetailContent(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;
  @override
  Widget build(BuildContext context) {
    final AccommodationScreenController screenController = Get.find();
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccommodationDetailNameAndRatingSection(
                  accommodationObject: accommodationObject),
              const SizedBox(
                height: 24,
              ),
              const AccommodationDetailTabs(),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Obx(() {
                  return screenController.selectedTab ==
                          AccommodationDetailTabEnum.about
                      ? AccommodationDetailAboutTabContent(
                          accommodationObject: accommodationObject)
                      : screenController.selectedTab ==
                              AccommodationDetailTabEnum.gallery
                          ? AccommodationDetailGalleryTabContent(
                              accommodationObject: accommodationObject)
                          : AccommodationDetailReviewsTabContent(
                              accommodationObject: accommodationObject);
                }),
              )
            ],
          ),
        ));
  }
}
