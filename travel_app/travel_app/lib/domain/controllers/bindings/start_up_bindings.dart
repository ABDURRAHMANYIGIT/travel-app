import 'package:get/get.dart';

import 'auth_binding.dart';
import 'example_binding.dart';
import 'purchase_binding.dart';
import 'splash_binding.dart';
import 'user_binding.dart';

class StartUpBindings extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    UserBinding().dependencies();
    ExampleBinding().dependencies();
    SplashBinding().dependencies();
    PurchaseBinding().dependencies();
  }
}
