import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_widgets/custom_button.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.gradient,
    this.fontSize,
    this.height = 50,
    this.width = 50,
    this.color,
    this.padding,
    required this.buttonName,
  });

  final VoidCallback onTap;
  final LinearGradient? gradient;
  final double? fontSize;
  final double width;
  final double height;
  final SvgPicture icon;
  final Color? color;
  final EdgeInsets? padding;
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      padding: padding,
      onTap: onTap,
      fontSize: fontSize,
      height: height,
      width: width,
      gradient: gradient,
      color: color,
      buttonName: buttonName,
      child: icon,
    );
  }
}
