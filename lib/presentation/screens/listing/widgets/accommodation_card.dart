import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/accommodation.dart';
import '../../../../resources/file_paths/icons.dart';
import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/image_asset.dart';
import '../../../global_components/texts/custom_text.dart';

class AccommodationCard extends StatelessWidget {
  const AccommodationCard({super.key, required this.accommodation, this.onTap});
  final AccommodationObject accommodation;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 240,
        width: Get.width,
        child: Stack(
          children: [
            ImageAsset(
              accommodation.photo!,
              fit: BoxFit.cover,
              width: Get.width,
            ),
            Column(
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
                              AppIcons.starFilled,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CustomText(
                              accommodation.rate.toString(),
                              style: AppTextStyle.bodyMedium(
                                  color: AppColors.black),
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
                    color: AppColors.grey.withOpacity(0.7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            accommodation.name ?? '',
                            style: AppTextStyle.bodyMedium(
                              color: AppColors.white,
                            ),
                          ),
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
                                  weight: AppTextStyle.fontLight,
                                  color: AppColors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      CustomText(
                        '\$${accommodation.costPerPerson.toString()}',
                        style: AppTextStyle.bodyMedium(
                          weight: AppTextStyle.fontMedium,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
