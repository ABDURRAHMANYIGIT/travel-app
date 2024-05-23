import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../resources/styles/app_theme.dart';
import '../helpers/get_storage_helper.dart';

class ThemeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool _isDarkMode = RxBool(false);
  bool get isDarkMode => _isDarkMode.value;
  Rxn<Animation<double>?> darkModeAnimationController =
      Rxn<Animation<double>?>(const AlwaysStoppedAnimation<double>(1));
  late AnimationController animationController;
  final GetStorageHelper getStorageHelper = GetStorageHelper();
  ThemeData getCurrentTheme() {
    if (isDarkMode) {
      return ThemeDataHelper().themeDataDark;
    } else {
      return ThemeDataHelper().themeData;
    }
  }

  ThemeMode getCurrentThemeMode() {
    if (isDarkMode) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode.value = !_isDarkMode.value;

    GetStorageHelper().setDarkMode(_isDarkMode.value);
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _isDarkMode.value
        ? animationController.forward(from: 0.5)
        : animationController.animateBack(220 / 321);
    SystemChrome.setSystemUIOverlayStyle(_isDarkMode.value
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    update();
  }

  @override
  Future<void> onInit() async {
    animationController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _isDarkMode.value = GetStorageHelper().getDarkMode();
    SystemChrome.setSystemUIOverlayStyle(_isDarkMode.value
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);
    if (_isDarkMode.value) {
      animationController.animateTo(0);
    } else {
      animationController.animateTo(0.5);
    }
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.reverse) {}
    });
    super.onInit();
  }
}
