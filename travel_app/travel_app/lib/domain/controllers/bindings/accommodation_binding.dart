import 'package:get/get.dart';

import '../data_controller/accommodation_controller.dart';

class AccommodationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AccommodationController>(AccommodationController(),
        permanent: true);
  }
}
