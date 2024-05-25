import 'package:get/get.dart';

import '../../../data/models/accommodation.dart';
import '../data_controller/accommodation_controller.dart';

class ListingScreenController extends GetxController {
  final AccommodationController _accommodationController = Get.find();
  List<AccommodationObject> get accommodationList =>
      _accommodationController.accommodationList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
