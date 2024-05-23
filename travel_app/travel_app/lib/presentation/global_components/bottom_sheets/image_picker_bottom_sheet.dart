import 'package:flutter/material.dart';

import '../../../../../resources/i18n/app_sentences.dart';
import '../../../../../resources/styles/colors.dart';
import '../../../../../resources/styles/text_styles.dart';
import '../../../resources/file_paths/icons.dart';
import '../../layouts/bottom_sheet_layout.dart';
import '../image_asset.dart';
import '../texts/custom_text.dart';

// TODO(ALL): Replace colors, icons and sentences
class ImagePickerBottomSheetContent extends StatelessWidget {
  const ImagePickerBottomSheetContent({
    super.key,
    required this.scrollController,
    this.onTapCamera,
    this.onTapGallery,
    this.title,
  });
  final Function? onTapCamera;
  final Function? onTapGallery;
  final ScrollController scrollController;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return BottomSheetLayout(
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                AppSentences().exampleSentence,
                maxLines: 3,
                style: AppTextStyle.h4(
                  color: AppColors.grey,
                ),
              ),
              const ImageAsset(AppIcons.close)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0,
            leading: const ImageAsset(
              AppIcons.arrowDown,
              color: AppColors.grey,
              fit: BoxFit.fitHeight,
            ),
            title: CustomText(
              AppSentences().exampleSentence,
              textAlign: TextAlign.start,
              style: AppTextStyle.bodyMedium(
                weight: AppTextStyle.fontMedium,
                color: AppColors.grey,
              ),
            ),
            onTap: () {
              onTapGallery?.call();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0,
            leading: const ImageAsset(
              AppIcons.arrowLeft,
              color: AppColors.grey,
              fit: BoxFit.fitHeight,
            ),
            title: CustomText(
              AppSentences().exampleSentence,
              textAlign: TextAlign.start,
              style: AppTextStyle.bodyMedium(
                weight: AppTextStyle.fontMedium,
                color: AppColors.grey,
              ),
            ),
            onTap: () async {
              onTapCamera?.call();
            },
          ),
        ],
      ),
    );
  }
}
