import 'package:flutter/material.dart';

import '../../../resources/styles/text_styles.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textOverflow = TextOverflow.ellipsis,
    this.isItalic = false,
    this.style,
  });

  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool isItalic;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: style ?? AppTextStyle.bodyMedium(),
    );
  }
}

enum CustomTextStyle {
  heading1,
  heading2,
  heading3,
  heading4,
  heading5,
  heading6,
  bodyXLarge,
  bodyLarge,
  bodyMedium,
  bodySmall,
  bodyXSmall,
}

extension CustomTextStyleExtension on CustomTextStyle {
  TextStyle get customTextStyle {
    switch (this) {
      case CustomTextStyle.heading1:
        return AppTextStyle.h1();
      case CustomTextStyle.heading2:
        return AppTextStyle.h2();
      case CustomTextStyle.heading3:
        return AppTextStyle.h3();
      case CustomTextStyle.heading4:
        return AppTextStyle.h4();
      case CustomTextStyle.heading5:
        return AppTextStyle.h5();
      case CustomTextStyle.heading6:
        return AppTextStyle.h6();
      case CustomTextStyle.bodyXLarge:
        return AppTextStyle.bodyXLarge();
      case CustomTextStyle.bodyLarge:
        return AppTextStyle.bodyLarge();
      case CustomTextStyle.bodyMedium:
        return AppTextStyle.bodyMedium();
      case CustomTextStyle.bodySmall:
        return AppTextStyle.bodySmall();
      case CustomTextStyle.bodyXSmall:
        return AppTextStyle.bodyXSmall();
    }
  }
}
