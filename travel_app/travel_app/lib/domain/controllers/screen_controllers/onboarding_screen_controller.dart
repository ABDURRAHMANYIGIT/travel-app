import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/file_paths/images.dart';
import '../../../resources/styles/animation/animation_values.dart';
import '../../router/route.dart';

class OnboardingScreenController extends GetxController {
  final Rx<String> _onboardingBackgroundImage =
      Rx<String>(AppImages.exampleImage);
  String get onboardingBackgroundImage => _onboardingBackgroundImage.value;

  List<String> onboardingPageImageList = <String>[
    AppImages.exampleImage,
    AppImages.exampleImage,
    AppImages.exampleImage,
  ];
  int get pageCount => onboardingPageImageList.length;
  bool get lastOnBoarding => currentPage == pageCount - 1;
  @override
  void onInit() {
    onboardingPageController.addListener(
      () {
        if (onboardingPageController.page != null) {
          _currentPage.value = onboardingPageController.page!.floor();
        }
      },
    );

    super.onInit();
  }

  RxInt onboardingPageIndex = RxInt(0);
  PageController onboardingPageController = PageController();
  final RxInt _currentPage = RxInt(0);
  int get currentPage => _currentPage.value;

  void onboardingNextPage() {
    if (lastOnBoarding) {
      Get.offAllNamed(AppRouter.designRoute);
    } else {
      onboardingPageController.nextPage(
        duration: AnimationValues.shortDuration,
        curve: Curves.linear,
      );
    }
    update();
  }

  void onTapSkipForNow() {
    log('onTapSkipForNow');
    Get.offAllNamed(AppRouter.designRoute);
  }

  void onTapLogin() {
    log('onTapLogin');
    Get.toNamed(AppRouter.designRoute);
  }

  void onTapRegister() {
    log('onTapRegister');
    Get.toNamed(AppRouter.designRoute);
  }

  void onTapOtp() {
    log('onTapOtp');
    Get.toNamed(AppRouter.designRoute);
  }
}
