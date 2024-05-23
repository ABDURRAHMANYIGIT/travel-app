import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/styles/colors.dart';
import '../../resources/styles/text_styles.dart';

import 'clickable_widget.dart';

//* State management will be added when provider is implemented.
class LoginRegisterTab extends StatelessWidget {
  const LoginRegisterTab(
      {super.key, required this.isLoginSelected, required this.onSelect});

  final bool isLoginSelected;
  final Function(bool isLoginSelected) onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 220.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.grey,
        ),
        child: Row(
          children: <Widget>[
            BuildTab(
                onTap: () {
                  onSelect(true);
                },
                text: 'Login',
                textColor:
                    isLoginSelected ? AppColors.grey : AppColors.etrexioPurple,
                color: isLoginSelected ? AppColors.etrexioPurple : null),
            BuildTab(
                onTap: () {
                  onSelect(false);
                },
                text: 'Register',
                textColor:
                    isLoginSelected ? AppColors.etrexioPurple : AppColors.grey,
                color: isLoginSelected ? null : AppColors.etrexioPurple)
          ],
        ),
      ),
    );
  }
}

class BuildTab extends StatelessWidget {
  const BuildTab({
    super.key,
    required this.onTap,
    required this.text,
    required this.textColor,
    required this.color,
  });

  final VoidCallback onTap;
  final String text;
  final Color textColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClickableWidget(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 110.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          text,
          style: AppTextStyle.bodyXLarge(
            color: textColor,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
