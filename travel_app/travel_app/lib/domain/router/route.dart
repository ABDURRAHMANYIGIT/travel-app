import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/screens/design_router_screen.dart';
import '../../presentation/screens/landing/landing_screen.dart';
import '../../presentation/screens/listing/listing_screen.dart';
import '../../presentation/screens/accommodation_detail/accommodation_detail_screen.dart';
import '../../presentation/screens/onboarding_screen/onboarding_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/ui_test/ui_test.dart';

class AppRouter {
  AppRouter._();

  static String get initialRoute => '/splash';

  static GetPage<dynamic> notFound =
      GetPage<dynamic>(name: notFoundRoute, page: () => Container());

  static const String notFoundRoute = '/not-found';
  static const String splashScreen = '/splash';

  static const String landingRoute = '/landing';
  static const String onboardingRoute = '/onboarding';

  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String forgotPassRoute = '/forgot_pass';

  static const String settingsRoute = '/settings';

  static const String designRoute = '/design_route';
  static const String uiTest = '/ui_test';
  static const String listingRoute = '/listing';
  static const String accommodationDetailRoute = '/accommodation-detail';
/* 
  static final List<Bindings> _homeBindings = <Bindings>[
     XPageBinding(),
     YPageBinding(),
     ZPageBinding(),
  ]; */

  static List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    notFound,
    GetPage<dynamic>(
      name: designRoute,
      page: () => const DesignRouterScreen(),
    ),
    GetPage<dynamic>(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage<dynamic>(
      name: landingRoute,
      page: () => const LandingScreen(),
    ),
    GetPage<dynamic>(
      name: onboardingRoute,
      page: () => const OnboardingScreen(),
    ),
    GetPage<dynamic>(
      name: uiTest,
      page: () => const UiTestScreen(),
    ),
    GetPage<dynamic>(
      name: listingRoute,
      page: () => const ListingScreen(),
    ),
  ];
}
