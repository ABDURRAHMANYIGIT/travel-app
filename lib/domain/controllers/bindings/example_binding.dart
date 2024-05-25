import 'package:get/get.dart';

import '../example/example_controller.dart';

class ExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExampleController>(ExampleController(), permanent: true);
  }
}
