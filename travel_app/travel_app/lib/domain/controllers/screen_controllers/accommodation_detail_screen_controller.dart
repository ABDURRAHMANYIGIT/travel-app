import 'package:get/get.dart';

import '../../../data/models/accommodation.dart';
import '../data_controller/accommodation_controller.dart';

class AccommodationDetailScreenController extends GetxController {
  AccommodationDetailScreenController(this.accommodationId);
  final int accommodationId;

  final AccommodationController _accommodationController = Get.find();

  final Rxn<AccommodationObject> _accommodationObject = Rxn();
  AccommodationObject? get accommodationObject => _accommodationObject.value;

  @override
  void onInit() async {
    _accommodationObject.value = await _accommodationController
        .getAccommodationById(id: accommodationId);
    super.onInit();
  }

  @override
  void onClose() {
    _accommodationObject.value = null;
    super.onClose();
  }
}
