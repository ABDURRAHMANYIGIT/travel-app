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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          accommodationObject.name ?? '',
          maxLines: null,
          textAlign: TextAlign.left,
          textOverflow: TextOverflow.visible,
          style: AppTextStyle.h3(
            color: AppColors.black,
          ),
        ),
        Row(
          children: [
            const ImageAsset(
              AppIcons.star,
              width: 20,
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
    );
  }
}
