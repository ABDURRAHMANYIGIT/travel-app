import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/styles/colors.dart';
import '../../../resources/styles/text_styles.dart';
import '../texts/custom_text.dart';
import 'custom_checkbox.dart';

class CustomCheckboxWithTitleWidget extends StatelessWidget {
  const CustomCheckboxWithTitleWidget({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });
  final String title;
  final RxnBool value;
  final Function(bool? value)? onChanged;
  @override
  Widget build(BuildContext context) {
    log('build-CustomCheckboxWithTitleWidget');
    return Row(
      children: <Widget>[
        CustomCheckBox(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(
          width: 6,
        ),
        CustomText(
          title,
          style: AppTextStyle.bodyMedium(
            weight: AppTextStyle.fontSemibold,
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}
