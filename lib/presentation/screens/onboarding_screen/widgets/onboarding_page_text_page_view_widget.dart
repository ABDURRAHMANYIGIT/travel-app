import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/screen_controllers/onboarding_screen_controller.dart';
import '../../../../resources/i18n/app_sentences.dart';
import 'onboarding_page_layout.dart';

class OnboardingContentPages extends StatelessWidget {
  const OnboardingContentPages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenController onboardingScreenController = Get.find();
    return Expanded(
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: onboardingScreenController.onboardingPageController,
        onPageChanged: (int newPage) {},
        children: <Widget>[
          OnboardingPageLayout(
            content: AppSentences().exampleSentence,
          ),
          OnboardingPageLayout(
            content: AppSentences().exampleSentence,
          ),
          OnboardingPageLayout(
            content: AppSentences().exampleSentence,
          ),
        ],
      ),
    );
  }
}
