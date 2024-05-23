import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/screen_controllers/splash_screen_controller.dart';
import '../../../resources/file_paths/images.dart';
import '../../global_components/image_asset.dart';
import '../../layouts/main_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenController splashScreenController = Get.find();
    return MainLayout(
      content: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: 1.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: splashScreenController.animation!,
                child: const ImageAsset(
                  AppImages.exampleImage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
