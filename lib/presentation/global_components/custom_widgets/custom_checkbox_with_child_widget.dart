import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_checkbox.dart';

class CustomCheckboxWithChildWidget extends StatelessWidget {
  const CustomCheckboxWithChildWidget({
    super.key,
    required this.child,
    required this.value,
    this.onChanged,
  });
  final Widget child;
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
        child,
      ],
    );
  }
}
