import 'dart:convert' as convert;
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../data/models/user_object.dart';
import '../../helpers/shared_preference.dart';
import '../../repositories/index.dart';
import '../../router/route.dart';

enum AuthStatus { auth, notAuth, firstTime }

class AuthController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final Rxn<UserObject> authUser = Rxn<UserObject>();
  final Rx<AuthStatus> authStatus = Rx<AuthStatus>(AuthStatus.notAuth);
  UserObject? get getAuthUser => authUser.value;
  RxnString navigateTo = RxnString();
  final RxBool _redirectOnboarding = RxBool(false);
  bool get redirectOnboarding => _redirectOnboarding.value;
  bool isFirstLogin = false;
  Duration navigateDuration = const Duration(seconds: 2);

  String get avatarFileKey => 'avatar';
  final RxBool _inProgress = RxBool(false);
  bool get inProgress => _inProgress.value;
  @override
  Future<void> onInit() async {
    ever(authStatus, _handleAuthStatusChange);
    ever(navigateTo, _handleNavigateRouteChange);
    _redirectOnboarding.value = await SharedPreference().getSeen();
    if (redirectOnboarding) {
      navigateTo.value = AppRouter.onboardingRoute;
      update();
    }
    ever(authUser, _handleAuthUserChange);
    if (!redirectOnboarding) {
      await getUser();
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');
      // navigateBasedOnNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('Got onMessageOpenedApp!');
      log('Message data: ${message.data}');
      navigateBasedOnNotification(message);
    });
    super.onInit();
  }

  Future<void> navigateBasedOnNotification(RemoteMessage message) async {
    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
      Map<String, dynamic> mapData = message.data;
      if (mapData.containsKey('custom_data')) {
        mapData = convert.jsonDecode(mapData['custom_data'].toString())
            as Map<String, dynamic>;
        if (mapData.containsKey('redirect')) {
          if (mapData.containsKey('parameters')) {
            final Map<String, dynamic> parameters =
                mapData['parameters'] as Map<String, dynamic>;

            final Map<String, String> lastParameters = parameters.map(
                (String key, dynamic value) =>
                    MapEntry<String, String>(key, value.toString()));
            await Get.toNamed(mapData['redirect'] as String,
                parameters: lastParameters);
          } else {
            await Get.toNamed(mapData['redirect'] as String);
          }
        }
      }
    }
  }

  Future<void> getUser() async {
    _inProgress.value = true;
    authUser.value = await _databaseServices.getUser();
    _inProgress.value = false;
    update();
    await checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    if (authUser.value != null) {
      if (isFirstLogin) {
        authStatus.value = AuthStatus.firstTime;
      } else {
        authStatus.value = AuthStatus.auth;
      }
    } else {
      authStatus.value = AuthStatus.notAuth;
    }
    update();
  }

  void logout() {
    authUser.value = null;
    SharedPreference().deleteToken();
    authStatus.value = AuthStatus.notAuth;
    update();
  }

  // TODO(ALL): UPDATE ROUTES
  void _handleAuthStatusChange(AuthStatus event) {
    switch (event) {
      case AuthStatus.auth:
        navigateTo.value = AppRouter.designRoute;

        break;
      case AuthStatus.notAuth:
        navigateTo.value = AppRouter.designRoute;

        break;
      case AuthStatus.firstTime:
        navigateDuration = Duration.zero;
        navigateTo.value = AppRouter.onboardingRoute;
        break;
    }
    update();
  }

  void _handleAuthUserChange(UserObject? event) {
    if (event != null) {
      // It's auth
    } else {
      // Not valid user
    }
    update();
  }

  void _handleNavigateRouteChange(String? event) {
    if (event != null && Get.currentRoute != event) {
      Future<void>.delayed(navigateDuration, () {
        Get.offAllNamed(event);
      });
    }
  }
}
