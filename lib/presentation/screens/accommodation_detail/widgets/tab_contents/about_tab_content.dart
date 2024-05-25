import 'package:flutter/material.dart';

import '../../../../../data/models/accommodation.dart';
import '../../../../../resources/styles/text_styles.dart';
import '../../../../global_components/texts/custom_text.dart';

class AccommodationDetailAboutTabContent extends StatelessWidget {
  const AccommodationDetailAboutTabContent(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CustomText(
          'About',
          textAlign: TextAlign.left,
          style: AppTextStyle.bodyXLarge(),
        ),
        const SizedBox(
          height: 6,
        ),
        CustomText(
          accommodationObject.description ?? '',
          textAlign: TextAlign.left,
          textOverflow: TextOverflow.visible,
          style: AppTextStyle.bodyMedium(weight: AppTextStyle.fontLight),
        ),
      ],
    );
  }
}
