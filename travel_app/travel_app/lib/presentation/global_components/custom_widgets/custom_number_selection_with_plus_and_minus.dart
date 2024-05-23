import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../resources/file_paths/icons.dart';
import '../../../resources/styles/colors.dart';
import '../../../resources/styles/text_styles.dart';
import '../image_asset.dart';
import '../texts/custom_text.dart';

class CustomNumberSelectionWithPlusAndMinus extends StatelessWidget {
  const CustomNumberSelectionWithPlusAndMinus({
    super.key,
    this.onTapMinus,
    this.onTapPlus,
    required this.number,
    this.iconPath,
    this.maximum = 100,
    this.minimum = 0,
  });
  final Function? onTapMinus;
  final Function? onTapPlus;
  final int number;
  final String? iconPath;
  final int maximum;
  final int minimum;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        color: AppColors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (number <= minimum) {
                  return;
                }
                log('decrementRideRepetition');
                onTapMinus?.call();
              },
              child: const ImageAsset(
                AppIcons.arrowLeft,
                color: AppColors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  if (iconPath != null)
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: ImageAsset(
                            iconPath!,
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                  CustomText(
                    number.toString(),
                    style: AppTextStyle.bodyLarge(
                      weight: AppTextStyle.fontRegular,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (number >= maximum) {
                  return;
                }
                log('incrementRideRepetition');
                onTapPlus?.call();
              },
              child: const ImageAsset(
                AppIcons.arrowDown,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
