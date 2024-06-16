import 'package:get/get.dart';

import 'accommodation_binding.dart';
import 'auth_binding.dart';
import 'chat_binding.dart';
import 'example_binding.dart';
import 'purchase_binding.dart';
import 'splash_binding.dart';
import 'user_binding.dart';

class StartUpBindings extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    UserBinding().dependencies();
    ChatBinding().dependencies();
    ExampleBinding().dependencies();
    SplashBinding().dependencies();
    PurchaseBinding().dependencies();
    AccommodationBinding().dependencies();
  }
}
