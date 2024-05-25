import 'package:flutter/material.dart';

import '../../../../data/models/accommodation.dart';
import '../../../../resources/file_paths/icons.dart';
import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/image_asset.dart';
import '../../../global_components/texts/custom_text.dart';

class AccommodationDetailNameAndRatingSection extends StatelessWidget {
  const AccommodationDetailNameAndRatingSection(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              accommodationObject.name ?? '',
              maxLines: null,
              textAlign: TextAlign.left,
              textOverflow: TextOverflow.visible,
              style: AppTextStyle.h4(
                color: AppColors.black,
              ),
            ),
            Row(
              children: [
                const ImageAsset(
                  AppIcons.starFilled,
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  accommodationObject.rate.toString(),
                  style: AppTextStyle.bodyMedium(
                      color: AppColors.grey, weight: AppTextStyle.fontLight),
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  'Ratings',
                  style: AppTextStyle.bodyMedium(
                      color: AppColors.grey, weight: AppTextStyle.fontLight),
                ),
              ],
            )
          ],
        ),
        CustomText(
          '\$${accommodationObject.costPerPerson.toString()}',
          style: AppTextStyle.h6(),
        )
      ],
    );
  }
}
