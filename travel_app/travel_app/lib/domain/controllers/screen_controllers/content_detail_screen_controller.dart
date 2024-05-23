import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentDetailScreenController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxDouble _scrollPercentage = RxDouble(0.0);
  double get scrollPercentage => _scrollPercentage.value;

  @override
  void onInit() {
    scrollController.addListener(_calculateScrollPercentage);
    super.onInit();
  }

  void _calculateScrollPercentage() {
    if (scrollController.position.maxScrollExtent > 0) {
      _scrollPercentage.value = (scrollController.offset /
              scrollController.position.maxScrollExtent) *
          100;
      update();
    }
  }
}
