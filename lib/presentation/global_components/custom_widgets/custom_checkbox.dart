import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../resources/styles/colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    this.onChanged,
  });

  final RxnBool value;
  final Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    log('build-CustomCheckBox');
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: AppColors.etrexioPurple,
        checkboxTheme: CheckboxThemeData(
          fillColor: const MaterialStatePropertyAll<Color?>(
            AppColors.etrexioPurple,
          ),
          checkColor: const MaterialStatePropertyAll<Color?>(
            AppColors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
              color: AppColors.grey,
              width: 10,
              style: BorderStyle.none,
              strokeAlign: 1,
            ),
          ),
        ),
      ),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Obx(() {
          return Checkbox(
            onChanged: onChanged,
            value: value.value,
          );
        }),
      ),
    );
  }
}
