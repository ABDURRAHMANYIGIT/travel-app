import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../domain/controllers/theme_controller.dart';
import '../../domain/utils/mixpanel_util.dart';
import '../../resources/file_paths/json.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return GestureDetector(
      onTap: () async {
        MixpanelHelper().track(
          'Selected Theme - ',
          properties: <String, String>{
            'dark_mode': (!themeController.isDarkMode).toString()
          },
        );

        themeController.toggleDarkMode();
      },
      child: Lottie.asset(AppJsons.timer,
          height: 35.h, controller: themeController.animationController,
          onLoaded: (LottieComposition composition) {
        themeController.animationController.duration = Duration(
          milliseconds: (composition.duration.inMilliseconds / 2).ceil(),
        );
      }),
    );
  }
}
