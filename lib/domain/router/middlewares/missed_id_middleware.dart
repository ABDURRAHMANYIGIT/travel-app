import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../route.dart';

class MissedIdMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final String id = Get.parameters['id'] ?? '';
    if (id.isEmpty) {
      return const RouteSettings(name: AppRouter.notFoundRoute);
    }
    return null;
  }
}
