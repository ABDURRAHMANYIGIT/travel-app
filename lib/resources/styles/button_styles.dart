// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import 'colors.dart';

class AppButtonStyle {
/*fonts*/

  static ButtonStyle black({
    Color? color,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor ?? AppColors.white,
          // width: 1,
        ),
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(8),
      ),
      backgroundColor: AppColors.black,
      shadowColor: AppColors.transparent,
      padding: padding,
    );
  }

  static ButtonStyle white({
    Color? color,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(8),
      ),
      backgroundColor: AppColors.white,
      shadowColor: AppColors.transparent,
      padding: padding,
    );
  }

  static ButtonStyle callToAction({
    Color? color,
    BorderSide? borderSide,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: borderSide ?? BorderSide.none,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(8),
      ),
      // backgroundColor: color ?? AppColors.pink,
      shadowColor: AppColors.transparent,
      padding: padding,
    );
  }

  static ButtonStyle inactive({
    Color? color,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.white,
          // width: 1,
        ),
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(8),
      ),
      backgroundColor: AppColors.black,
      shadowColor: AppColors.transparent,
      padding: padding,
    );
  }

  static ButtonStyle hugged({
    Color? color,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.white,
          // width: 1,
        ),
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(8),
      ),
      backgroundColor: AppColors.black,
      shadowColor: AppColors.transparent,
      padding: padding,
    );
  }
}
