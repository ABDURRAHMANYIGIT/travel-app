import 'package:get/get.dart';

import '../../../data/models/collection.dart';
import '../../helpers/fcm_helper.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  final AuthController _authController = Get.find();

  final RxList<CollectionObject> _collectionList =
      RxList<CollectionObject>.empty();
  List<CollectionObject> get collectionList => _collectionList;

  final RxBool _inProgress = RxBool(false);
  bool get inProgress => _inProgress.value;

  @override
  Future<void> onInit() async {
    ever(_authController.authStatus, _handleAuthStatusChange);

    super.onInit();
  }

  Future<void> _handleAuthStatusChange(AuthStatus? event) async {
    if (event != null) {
      if (<AuthStatus>[AuthStatus.auth, AuthStatus.firstTime].contains(event)) {
      } else {
        resetUserData();
      }
    }
    update();
  }

  void resetUserData() {
    _collectionList.value = <CollectionObject>[];
    update();
  }

  Future<void> requestNotificationPermission() async {
    await FCMHelper().requestPermission();
  }
}
