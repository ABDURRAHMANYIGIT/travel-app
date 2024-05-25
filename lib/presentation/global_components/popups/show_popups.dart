import 'package:flutter/material.dart';

import '../../../resources/file_paths/images.dart';
import '../../../resources/i18n/app_sentences.dart';
import '../../../resources/styles/colors.dart';
import '../../../resources/styles/text_styles.dart';
import '../common_dialog.dart';
import '../image_asset.dart';
import '../texts/custom_text.dart';

class ShowPopUps {
  void showAreYouSurePopUp({
    Function? onConfirm,
    Function? onCancel,
    String? dialogName,
  }) {
    return showCommonDialog(
      title: const ImageAsset(AppImages.exampleImage),
      body: Column(
        children: <Widget>[
          CustomText(
            AppSentences().exampleSentence,
            maxLines: 3,
            style: AppTextStyle.h4(
              color: AppColors.black,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText(
            AppSentences().exampleSentence,
            maxLines: 3,
            style: AppTextStyle.bodyLarge(
              color: AppColors.black,
              weight: AppTextStyle.fontRegular,
            ),
          ),
        ],
      ),
      confirmButtonText: AppSentences().exampleSentence,
      confirmButtonBackgroundColor: AppColors.white,
      cancelButtonTextColor: AppColors.black,
      onConfirm: () {
        onConfirm?.call();
      },
      cancelButtonText: AppSentences().exampleSentence,
      onCancel: () {
        onCancel?.call();
      },
      dialogName: dialogName ?? 'showAreYouSurePopUp',
    );
  }
}
