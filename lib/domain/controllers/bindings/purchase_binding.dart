import 'package:get/get.dart';

import '../data_controller/purchase_controller.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PurchaseController>(PurchaseController(), permanent: true);
  }
}
