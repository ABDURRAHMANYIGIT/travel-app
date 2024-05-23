import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/file_paths/icons.dart';
import '../image_asset.dart';

class AppBarBackIconWidget extends StatelessWidget {
  const AppBarBackIconWidget({
    super.key,
    this.onTap,
    this.color,
  });
  final Function? onTap;
  final Color? color;
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
        AppIcons.arrowLeft,
        color: color,
      ),
    );
  }
}
