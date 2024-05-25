import 'package:get/get.dart';

import '../../../data/enums/accommodation_detail_tab_enum.dart';

class AccommodationScreenController extends GetxController {
  final Rx<AccommodationDetailTabEnum> _selectedTab =
      Rx<AccommodationDetailTabEnum>(AccommodationDetailTabEnum.about);
  AccommodationDetailTabEnum get selectedTab => _selectedTab.value;

  void selectTab(AccommodationDetailTabEnum tabEnum) {
    _selectedTab.value = tabEnum;
    update();
  }
}
