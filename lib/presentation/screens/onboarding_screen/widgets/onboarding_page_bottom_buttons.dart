import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/screen_controllers/onboarding_screen_controller.dart';
import '../../../../resources/i18n/app_sentences.dart';
import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/custom_widgets/custom_button.dart';
import '../../../global_components/texts/custom_text.dart';

class OnboardingPageBottomButtons extends StatelessWidget {
  const OnboardingPageBottomButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenController onboardingScreenController = Get.find();
    return Obx(
      () {
        if (onboardingScreenController.lastOnBoarding) {
          return const _LetsStartSkipForNow();
        } else {
          return const _NextButton();
        }
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenController onboardingScreenController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: CustomButton(
        width: 1.sw,
        height: 45.h,
        padding: const EdgeInsets.symmetric(vertical: 9),
        onTap: onboardingScreenController.onboardingNextPage,
        buttonName: 'Intro Screen Continue Button',
        gradient: AppColors.purpleGradient,
        borderRadius: 100,
        // style: AppButtonStyle.callToAction(),
        child: CustomText(
          AppSentences().exampleSentence,
          style: AppTextStyle.bodyLarge(
            color: AppColors.grey,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _LetsStartSkipForNow extends StatelessWidget {
  const _LetsStartSkipForNow();

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenController onboardingScreenController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Column(
        children: <Widget>[
          CustomButton(
            width: 1.sw,
            height: 45.h,
            padding: const EdgeInsets.symmetric(vertical: 9),
            onTap: onboardingScreenController.onTapLogin,
            buttonName: 'Onboarding Lets Start Button',
            gradient: AppColors.purpleGradient,
            borderRadius: 100,
            child: CustomText(
              AppSentences().exampleSentence,
              style: AppTextStyle.bodyLarge(
                weight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: AppSentences().exampleSentence,
                  style: AppTextStyle.bodyMedium(
                    color: AppColors.grey,
                    weight: AppTextStyle.fontRegular,
                  ),
                ),
                TextSpan(
                  text: AppSentences().exampleSentence,
                  style: AppTextStyle.bodyMedium(
                    color: AppColors.etrexioPurple,
                    weight: AppTextStyle.fontSemibold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      onboardingScreenController.onTapSkipForNow();
                    },
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
