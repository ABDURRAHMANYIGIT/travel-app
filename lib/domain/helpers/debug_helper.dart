
// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/foundation.dart';

class DebugHelper {
  static const bool debugMode = false;

  static void debugPrint(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
