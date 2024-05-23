import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../image_asset.dart';

class AppBarTrailingIconWidget extends StatelessWidget {
  const AppBarTrailingIconWidget({
    super.key,
    this.onTap,
    this.color,
    required this.iconPath,
  });
  final Function? onTap;
  final Color? color;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap?.call();
        } else {
          if (Navigator.canPop(context)) {
            Get.back();
          }
        }
      },
      child: ImageAsset(
        iconPath,
        color: color,
      ),
    );
  }
}
