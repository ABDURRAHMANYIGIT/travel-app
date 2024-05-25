import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/styles/colors.dart';
import 'texts/custom_text.dart';

class UnimplementedWidget extends StatelessWidget {
  const UnimplementedWidget({
    super.key,
    required this.widgetName,
    this.gradient,
  });
  final String widgetName;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.3.sh,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.purpleGradient,
      ),
      child: Center(
        child: CustomText(
          widgetName,
        ),
      ),
    );
  }
}
