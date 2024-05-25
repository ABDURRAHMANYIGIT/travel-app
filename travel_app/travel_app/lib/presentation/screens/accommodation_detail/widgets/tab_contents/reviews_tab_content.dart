import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../data/models/accommodation.dart';
import '../../../../../resources/file_paths/icons.dart';
import '../../../../../resources/styles/colors.dart';
import '../../../../../resources/styles/text_styles.dart';
import '../../../../global_components/image_asset.dart';
import '../../../../global_components/texts/custom_text.dart';

class AccommodationDetailReviewsTabContent extends StatelessWidget {
  const AccommodationDetailReviewsTabContent({
    Key? key,
    required this.accommodationObject,
  }) : super(key: key);

  final AccommodationObject accommodationObject;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                '${accommodationObject.rate}/5',
                style: AppTextStyle.h4(),
              ),
              const SizedBox(height: 8),
              buildStarRating(rate: accommodationObject.rate!, size: 24),
              const SizedBox(height: 8),
              CustomText(
                '25 Rating',
                style: AppTextStyle.bodySmall(
                    weight: AppTextStyle.fontLight, color: AppColors.lightGrey),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  buildStarRating(rate: 5, size: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // Set the width according to your requirement
                    child: LinearProgressIndicator(
                      value: 0.5,
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: AppColors.lightGrey,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  buildStarRating(rate: 4, size: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // Set the width according to your requirement
                    child: LinearProgressIndicator(
                      value: 0.8,
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: AppColors.lightGrey,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  buildStarRating(rate: 3, size: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // Set the width according to your requirement
                    child: LinearProgressIndicator(
                      value: 0.7,
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: AppColors.lightGrey,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  buildStarRating(rate: 2, size: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // Set the width according to your requirement
                    child: LinearProgressIndicator(
                      value: 0.1,
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: AppColors.lightGrey,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  buildStarRating(rate: 1, size: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // Set the width according to your requirement
                    child: LinearProgressIndicator(
                      value: 0.1,
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: AppColors.lightGrey,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildStarRating({required double rate, double? size}) {
    List<Widget> stars = [];
    int fullStars = rate.floor();
    double remainder = rate - fullStars;

    for (int i = 0; i < fullStars; i++) {
      stars.add(ImageAsset(
        AppIcons.starFilled,
        width: size,
        height: size,
      ));
    }

    if (remainder > 0) {
      if (remainder <= 1) {
        stars.add(ImageAsset(
          AppIcons.starSlash,
          width: size,
          height: size,
        ));
      } else {
        stars.add(ImageAsset(
          AppIcons.starEmpty,
          width: size,
          height: size,
        ));
      }
    }

    while (stars.length < 5) {
      stars.add(ImageAsset(
        AppIcons.starEmpty,
        width: size,
        height: size,
      ));
    }

    return Row(children: stars);
  }
}
