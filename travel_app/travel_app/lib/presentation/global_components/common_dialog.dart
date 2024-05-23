import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/utils/mixpanel_util.dart';
import '../../resources/styles/colors.dart';
import '../../resources/styles/text_styles.dart';
import 'custom_widgets/custom_dialog_button.dart';
import 'texts/custom_text.dart';

void showCommonDialog({
  required Widget title,
  required Widget body,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  bool dismissable = true,
  bool isLarge = false,
  String? confirmButtonText,
  String? cancelButtonText,
  required String dialogName,
  Color? confirmButtonBackgroundColor,
  Color? cancelButtonTextColor,
}) {
  Get.dialog(
    CommonDialog(
      title: title,
      body: body,
      onConfirm: onConfirm,
      onCancel: onCancel,
      isLarge: isLarge,
      dialogName: dialogName,
      cancelText: cancelButtonText,
      confirmButtonOverride: confirmButtonText != null
          ? CustomText(
              confirmButtonText,
              style: AppTextStyle.bodyLarge(
                color: AppColors.white,
                weight: AppTextStyle.fontBold,
              ),
            )
          : null,
      confirmButtonBackgroundColor: confirmButtonBackgroundColor,
      cancelButtonTextColor: cancelButtonTextColor,
    ),
    barrierDismissible: dismissable,
  );
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    required this.title,
    required this.body,
    required this.onConfirm,
    this.onCancel,
    this.cancelText = 'CANCEL',
    this.confirmButtonOverride,
    this.cancelButtonOverride,
    this.isLarge = false,
    required this.dialogName,
    this.confirmButtonBackgroundColor,
    this.cancelButtonTextColor,
  });

  final Widget title;
  final Widget body;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String? cancelText;
  final Widget? confirmButtonOverride;
  final Widget? cancelButtonOverride;
  final bool isLarge;
  final String dialogName;
  final Color? confirmButtonBackgroundColor;
  final Color? cancelButtonTextColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: isLarge ? 24.0 : 40.0,
        ),
        constraints: BoxConstraints(
          maxWidth: Get.width,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          title,
          const SizedBox(height: 25.0),
          body,
          const SizedBox(height: 25.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (onCancel != null)
                _getConfirmButton(confirmButtonBackgroundColor)
              else
                _getConfirmButton(confirmButtonBackgroundColor),
              if (onCancel != null) const SizedBox(height: 12.0),
              if (onCancel != null)
                _getCancelButton(cancelText ?? 'CANCEL', cancelButtonTextColor),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _getCancelButton(String text, Color? textColor) {
    return CustomDialogButton(
      onTap: () {
        MixpanelHelper().track('$dialogName Dialog Cancel Button Click');
        onCancel?.call();
      },
      color: AppColors.white,
      borderRadius: 100,
      buttonName: dialogName,
      child: cancelButtonOverride ??
          CustomText(
            text,
            style: AppTextStyle.bodyMedium(
              color: textColor ?? AppColors.black,
              weight: AppTextStyle.fontBold,
            ),
          ),
    );
  }

  Widget _getConfirmButton(Color? backgrounColor) {
    return CustomDialogButton(
      onTap: () {
        MixpanelHelper().track('$dialogName Dialog Confirm Button Click');
        onConfirm();
      },
      gradient: backgrounColor == null ? AppColors.purpleGradient : null,
      color: backgrounColor,
      borderRadius: 16,
      buttonName: dialogName,
      child: confirmButtonOverride ??
          const Text(
            'OK',
            style: TextStyle(
              color: AppColors.etrexioPurple,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
    );
  }
}
