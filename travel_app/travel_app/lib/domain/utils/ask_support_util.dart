import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/config/app_info.dart';
import '../../resources/i18n/app_sentences.dart';

class AskSupportUtil {
  Future<void> askSupport() async {
    String deviceInfo =
        '${AppSentences().deviceInfo} \n ------------------------------------- \n\n';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo =
          await _getDeviceInfo() as AndroidDeviceInfo;
      const AndroidId androidIdPlugin = AndroidId();
      final Map<String, dynamic> androidData = <String, dynamic>{
        'version.securityPatch': androidInfo.version.securityPatch,
        'version.sdkInt': androidInfo.version.sdkInt,
        'version.release': androidInfo.version.release,
        'version.previewSdkInt': androidInfo.version.previewSdkInt,
        'version.incremental': androidInfo.version.incremental,
        'version.codename': androidInfo.version.codename,
        'version.baseOS': androidInfo.version.baseOS,
        'board': androidInfo.board,
        'bootloader': androidInfo.bootloader,
        'brand': androidInfo.brand,
        'device': androidInfo.device,
        'display': androidInfo.display,
        'fingerprint': androidInfo.fingerprint,
        'hardware': androidInfo.hardware,
        'host': androidInfo.host,
        'id': androidInfo.id,
        'manufacturer': androidInfo.manufacturer,
        'model': androidInfo.model,
        'product': androidInfo.product,
        'supported32BitAbis': androidInfo.supported32BitAbis,
        'supported64BitAbis': androidInfo.supported64BitAbis,
        'supportedAbis': androidInfo.supportedAbis,
        'tags': androidInfo.tags,
        'type': androidInfo.type,
        'isPhysicalDevice': androidInfo.isPhysicalDevice,
        'androidId': await androidIdPlugin.getId() ?? 'Unknown ID',
        'systemFeatures': androidInfo.systemFeatures,
      };
      androidData.forEach((String key, dynamic value) {
        deviceInfo += '${key.toUpperCase()} => $value \n';
      });
    }

    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _getDeviceInfo() as IosDeviceInfo;

      final Map<String, dynamic> iosData = <String, dynamic>{
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
        'localizedModel': iosInfo.localizedModel,
        'identifierForVendor': iosInfo.identifierForVendor,
        'isPhysicalDevice': iosInfo.isPhysicalDevice,
        'utsname.sysname:': iosInfo.utsname.sysname,
        'utsname.nodename:': iosInfo.utsname.nodename,
        'utsname.release:': iosInfo.utsname.release,
        'utsname.version:': iosInfo.utsname.version,
        'utsname.machine:': iosInfo.utsname.machine,
      };
      iosData.forEach((String key, dynamic value) {
        deviceInfo += '${key.toUpperCase()} => $value \n';
      });
    }

    deviceInfo += '\n\n\n\n\n-------------------------------------';

    final String message =
        '${AppSentences().supportContent} \n\n\n\n\n ------------------------------------- \n $deviceInfo';
    final String subject = 'Kidu ${AppSentences().support}';

    final Email email = Email(
      body: message,
      subject: subject,
      recipients: <String>[
        AppInfo.contactEmail,
      ],
    );
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final Uri params = Uri(
        scheme: 'mailto',
        path: email.recipients.first,
        query: Uri.encodeFull('subject=${email.subject}'),
      );

      await launchUrl(params);
    } else {
      await FlutterEmailSender.send(email);
    }
    Get.snackbar(
        AppSentences().supportFeedback, AppSentences().thanksForContactingUs,
        animationDuration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10));
  }

  Future<dynamic> _getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // print(deviceInfo);
    if (Platform.isAndroid) {
      return deviceInfo.androidInfo;
    }
    if (Platform.isIOS) {
      return deviceInfo.iosInfo;
    }
  }
}
