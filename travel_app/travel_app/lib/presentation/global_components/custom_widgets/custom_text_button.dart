import 'package:flutter/material.dart';
import '../../../resources/styles/colors.dart';

import '../../../resources/styles/text_styles.dart';
import 'custom_button.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.gradient,
      this.fontSize,
      this.height = 50,
      this.width,
      this.color,
      this.padding,
      this.textColor,
      this.textStyle,
      this.textAlign,
      this.borderRadius,
      required this.buttonName});

  final VoidCallback onTap;
  final String text;
  final LinearGradient? gradient;
  final double? fontSize;
  final double? width;
  final double height;
  final Color? color;
  final EdgeInsets? padding;
  final Color? textColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double? borderRadius;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      padding: padding,
      borderRadius: borderRadius,
      fontSize: fontSize,
      height: height,
      width: width,
      color: color ?? AppColors.transparent,
      buttonName: buttonName,
      child: Text(
        text,
        style: textStyle ??
            AppTextStyle.bodyMedium(
              weight: AppTextStyle.fontSemibold,
              color: textColor ?? AppColors.grey,
            ),
        textAlign: textAlign,
      ),
    );
  }
}
