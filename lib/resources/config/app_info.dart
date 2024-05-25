class AppInfo {
  factory AppInfo() => _instance;
  AppInfo._internal();

  static const String appName = 'Commonground';

  static final AppInfo _instance = AppInfo._internal();
  static const String revenueCatAndroidID = 'goog_xxxx';
  static const String revenueCatiosID = 'appl_xxxx';

  static const String mixpanelId = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';

  static const String baseDevDynamicLinkUrl = 'commongrounddev.page.link';
  static const String baseProdDynamicLinkUrl = 'commonground.page.link';
  static const String packageName =
      'com.commonground.example'; // TODO(ALL): UPDATE PACKAGE NAME

  // App store id for IOS
  static const String appStoreId =
      '6443471404'; // TODO(ALL): UPDATE APP STORE ID
  static const String fullAppStoreId = 'id$appStoreId';

  static String getBaseDynamicLinkUrl({required bool production}) {
    if (production) {
      return baseProdDynamicLinkUrl;
    } else {
      return baseDevDynamicLinkUrl;
    }
  }

  static const String websiteDomainURL = 'https://www.etrexio.com/';
  static const String contactEmail = 'hey@etrexio.com';
  static const String privacyPolicyLink = 'https://www.etrexio.com';
}
