import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/accommodation.dart';
import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/image_asset.dart';
import '../../../global_components/texts/custom_text.dart';
import 'name_and_rating.dart';

class AccommodationDetailContent extends StatelessWidget {
  const AccommodationDetailContent(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Durations.extralong2,
      bottom: 0,
      left: 0,
      right: 0,
      height: Get.height * 0.6,
      child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.12, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccommodationDetailNameAndRatingSection(
                    accommodationObject: accommodationObject),
                const SizedBox(
                  height: 24,
                ),
                CustomText(
                  'About',
                  style: AppTextStyle.bodyXLarge(),
                ),
                const SizedBox(
                  height: 6,
                ),
                CustomText(
                  accommodationObject.description ?? '',
                  textAlign: TextAlign.left,
                  textOverflow: TextOverflow.visible,
                  style:
                      AppTextStyle.bodyMedium(weight: AppTextStyle.fontLight),
                )
              ],
            ),
          )),
    );
  }
}
