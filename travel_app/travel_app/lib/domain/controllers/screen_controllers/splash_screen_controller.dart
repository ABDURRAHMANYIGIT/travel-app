import 'dart:async';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  AnimationController? controller2;
  Animation<double>? animation2;
  @override
  Future<void> onInit() async {
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
      value: 0,
    );
    animation =
        CurvedAnimation(parent: controller!, curve: Curves.fastOutSlowIn);
    controller!.forward().whenComplete(() => <Animation<double>>{
          controller2 = AnimationController(
              duration: const Duration(milliseconds: 1200),
              vsync: this,
              value: 0),
          animation2 =
              CurvedAnimation(parent: controller!, curve: Curves.fastOutSlowIn),
        });
    super.onInit();
  }

  // final DynamicLinkApi _dynamicLinkApi = DynamicLinkApi();

  Future<void> handleDynamicLinkData(PendingDynamicLinkData? data) async {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      log('[Deeplink Detected]');
    }
  }

  @override
  void onClose() {
    controller!.dispose();
    controller2!.dispose();
    super.onClose();
  }
}
