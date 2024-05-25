import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/screen_controllers/onboarding_screen_controller.dart';
import '../../../resources/styles/colors.dart';
import '../../layouts/main_layout.dart';
import 'widgets/onboarding_page_bottom_buttons.dart';
import 'widgets/onboarding_page_indicators.dart';
import 'widgets/onboarding_page_text_page_view_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingScreenController());
    return MainLayout(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.white,
      content: Column(
        children: <Widget>[
          const OnboardingContentPages(),
          Column(
            children: <Widget>[
              const OnboardingPageIndicators(),
              const OnboardingPageBottomButtons(),
              SizedBox(
                height: 35.h,
              )
            ],
          ),
        ],
      ),
    );
  }
}
