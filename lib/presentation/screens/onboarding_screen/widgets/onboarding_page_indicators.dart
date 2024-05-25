import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../domain/controllers/screen_controllers/onboarding_screen_controller.dart';
import '../../../../resources/styles/colors.dart';

class OnboardingPageIndicators extends StatelessWidget {
  const OnboardingPageIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenController onboardingScreenController = Get.find();

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: SmoothPageIndicator(
        controller: onboardingScreenController.onboardingPageController,
        count: onboardingScreenController.pageCount,
        effect: const ExpandingDotsEffect(
          activeDotColor: AppColors.etrexioPurple,
          dotColor: AppColors.grey,
          dotHeight: 8,
          dotWidth: 8,
          expansionFactor: 4,
        ),
      ),
    );
  }
}
