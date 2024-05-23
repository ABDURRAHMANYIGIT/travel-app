import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/accommodation.dart';
import '../../../resources/dummy_data/dummy_contents.dart';

class AccommodationController extends GetxController {
  final RxList<AccommodationObject> _accommodationList = RxList([]);
  List<AccommodationObject> get accommodationList => _accommodationList;

  @override
  void onInit() {
    getAccommodations();
    super.onInit();
    update();
  }

  Future<List<AccommodationObject>> getAccommodations() async {
    return await Future.delayed(Durations.extralong4,
        () => _accommodationList.value = DummyContent().dummyAccommodations);
  }

  Future<AccommodationObject> getAccommodationById({required int id}) async {
    return _accommodationList.where((element) => element.id == id).first;
  }
}
