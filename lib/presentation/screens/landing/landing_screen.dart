import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/file_paths/images.dart';
import '../../global_components/image_asset.dart';
import '../../layouts/main_layout.dart';
import '../design_router_screen.dart';
import 'widgets/landing_text.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(flex: 2),
          GestureDetector(
            onTap: () {
              Get.to(const DesignRouterScreen());
            },
            child: const Center(
              child: ImageAsset(
                AppImages.exampleImage,
              ),
            ),
          ),
          const Spacer(flex: 2),
          const Text('Landing Screen'),
          const LandingText(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
