import 'package:flutter/cupertino.dart';

import '../../../resources/styles/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });
  final bool value;
  final Function(bool value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: value,
        activeColor: AppColors.etrexioPurple,
        thumbColor: AppColors.white,
        trackColor: AppColors.lightGrey,
        onChanged: onChanged,
      ),
    );
  }
}
