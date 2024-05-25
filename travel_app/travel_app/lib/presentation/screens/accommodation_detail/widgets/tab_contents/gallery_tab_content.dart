import 'package:flutter/material.dart';

import '../../../../../data/models/accommodation.dart';
import '../../../../global_components/image_asset.dart';
import '../../../../global_components/texts/custom_text.dart';

class AccommodationDetailGalleryTabContent extends StatelessWidget {
  const AccommodationDetailGalleryTabContent(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;

  @override
  Widget build(BuildContext context) {
    return accommodationObject.photos != null
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
              childAspectRatio: 1.0, // Aspect ratio of each item
            ),
            itemCount: accommodationObject.photos!.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ImageAsset(
                accommodationObject.photos![index],
                fit: BoxFit.cover,
              ),
            ),
          )
        : const CustomText('There is no image to show');
  }
}
