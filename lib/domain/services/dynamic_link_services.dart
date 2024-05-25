import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

import '../../resources/config/app_info.dart';

class DynamicLinkApi {
  factory DynamicLinkApi() {
    return _dynamicLinkApi;
  }

  DynamicLinkApi._();
  static final DynamicLinkApi _dynamicLinkApi = DynamicLinkApi._();

  final String baseDynamicLinkUrl =
      AppInfo.getBaseDynamicLinkUrl(production: !kDebugMode);

  final String packageName = AppInfo.packageName;
  final FirebaseDynamicLinks dynamicLink = FirebaseDynamicLinks.instance;

  Stream<PendingDynamicLinkData> get onLink => dynamicLink.onLink;

  //Create share game link using the game id
  Future<String> createExampleLink({required String exampleId}) async {
    return createDynamicLink(
      dynamicLinkTitle: 'Share Example',
      dynamicLinDescription: 'Example Description',
      queryParameters: <String, String>{'example_id': exampleId},
    );
  }

  Future<String> createDynamicLink({
    String? dynamicLinkTitle,
    String? dynamicLinDescription,
    required Map<String, String> queryParameters,
    int androidMinVersion = 19, // TODO(ALL): UPDATE VERSION NUMBERS
    String iosMinVersion = '10', // TODO(ALL): UPDATE VERSION NUMBERS
    String endpoint = '/',
  }) async {
    final Uri uri = Uri.https(baseDynamicLinkUrl, endpoint, queryParameters);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://$baseDynamicLinkUrl',
      link: uri,
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: androidMinVersion,
      ),
      iosParameters: IOSParameters(
        bundleId: packageName,
        minimumVersion: iosMinVersion,
        appStoreId: AppInfo.appStoreId,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: dynamicLinkTitle,
        description: dynamicLinDescription,
      ),
    );
    final ShortDynamicLink longDynamicUrl =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    final Uri url = longDynamicUrl.shortUrl;
    return url.toString();
  }
}
