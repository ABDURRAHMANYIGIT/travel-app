import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/utils/mixpanel_util.dart';
import '../../resources/styles/colors.dart';
import 'common_dialog.dart';

/// Designed for show alert messages in user interface
abstract class DialogMessage {
  void show({
    required String title,
    required String body,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool dismissible = true,
    String? toRouteOnConfirm,
    Map<String, String>? toRouteOnConfirmArguments,
  });
}

class ConcreteDialog extends DialogMessage {
  @override
  void show({
    required String title,
    required String body,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool dismissible = true,
    String? toRouteOnConfirm,
    Map<String, String>? toRouteOnConfirmArguments,
  }) {
    showMessageDialog(
      title: title,
      body: body,
      onConfirm: onConfirm,
      onCancel: onCancel,
      dismissible: dismissible,
      toRouteOnConfirm: toRouteOnConfirm,
      toRouteOnConfirmArguments: toRouteOnConfirmArguments,
      confirmButtonText: 'OK',
    );
  }
}

void showMessageDialog({
  required String title,
  required String body,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool dismissible = true,
  String? toRouteOnConfirm,
  String? confirmButtonText,
  Map<String, String>? toRouteOnConfirmArguments,
}) {
  showCommonDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Text(
        body,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 16,
        ),
      ),
      onConfirm: onConfirm == null
          ? () {
              Get.back();
              if (toRouteOnConfirm != null) {
                MixpanelHelper().track('$title Dialog Confirm Button Click');
                Get.toNamed(toRouteOnConfirm,
                    parameters: toRouteOnConfirmArguments);
              }
            }
          : () {
              MixpanelHelper().track('$title Dialog Confirm Button Click');

              onConfirm();
              Get.back();
              if (toRouteOnConfirm != null) {
                Get.toNamed(toRouteOnConfirm,
                    parameters: toRouteOnConfirmArguments);
              }
            },
      onCancel: onCancel != null
          ? () {
              MixpanelHelper().track('$title Dialog Cancel Button Click');

              onCancel();
              Get.back();
            }
          : null,
      dismissable: dismissible,
      dialogName: title,
      confirmButtonText: confirmButtonText ?? 'OK');
}
