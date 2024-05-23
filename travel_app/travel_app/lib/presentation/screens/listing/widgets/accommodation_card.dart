import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../data/models/accommodation.dart';
import '../../../../domain/router/route.dart';
import '../../../../resources/file_paths/icons.dart';
import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/image_asset.dart';
import '../../../global_components/texts/custom_text.dart';

class AccommodationCard extends StatelessWidget {
  const AccommodationCard({super.key, required this.accommodation});
  final AccommodationObject accommodation;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRouter.accommodationDetailRoute,
          parameters: {'id': accommodation.id.toString()}),
      child: Container(
        width: Get.width,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.blue,
          image: accommodation.photo != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                    accommodation.photo!,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        const ImageAsset(
                          AppIcons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          accommodation.rate.toString(),
                          style:
                              AppTextStyle.bodyMedium(color: AppColors.black),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: ImageAsset(AppIcons.heart),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: AppColors.grey.withOpacity(0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(accommodation.name ?? ''),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const ImageAsset(
                            AppIcons.location,
                            width: 20,
                            color: AppColors.white,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          CustomText(
                            accommodation.location ?? '',
                            style: AppTextStyle.bodyMedium(
                                weight: AppTextStyle.fontLight),
                          )
                        ],
                      )
                    ],
                  ),
                  CustomText(
                    '\$${accommodation.costPerPerson.toString()}',
                    style: AppTextStyle.bodyMedium(
                        weight: AppTextStyle.fontMedium),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
