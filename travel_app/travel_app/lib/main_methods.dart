import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'domain/controllers/bindings/start_up_bindings.dart';
import 'domain/helpers/fcm_helper.dart';
import 'domain/helpers/shared_preference.dart';
import 'domain/services/connection_status.dart';
import 'translations.dart';
// import 'utils/mixpanel_util.dart';

late bool isFirstSeen;
late String? userId;

class MainMethods {
  Future<void> runInitialMethods() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    // TODO(ALL): uncomment if GetStorage will be used
    //await GetStorage.init();

    StartUpBindings().dependencies();

    await initSystemChromeSettings();

    isFirstSeen = await SharedPreference().getSeen();

    await initTranslations();
    // TODO(ALL): uncomment once Firebase notification is implemented
    // await initPushNotifications();
    // TODO(ALL): remove comment once add mixpanel id
    // await MixpanelHelper.init();
  }

  Future<void> initSystemChromeSettings() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    await setPreferredOrientations();
  }

  Future<void> setPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  Future<void> initTranslations() async {
    if (isFirstSeen) {
      final String sysLng = ui.PlatformDispatcher.instance.locale.languageCode;
      final String newLang = sysLng == 'tr' ? 'tr' : 'en';
      allTranslations.setNewLanguage(newLang, true);
      await SharedPreference().setAppLanguage(newLang);
      await SharedPreference().setSeen(false);
    }

    final String lang = await SharedPreference().getAppLanguage();
    await allTranslations.init(lang);
  }

  Future<void> initPushNotifications() async {
    await FCMHelper().init();
  }

  Future<void> initConnectionStatus() async {
    final ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
  }
}
