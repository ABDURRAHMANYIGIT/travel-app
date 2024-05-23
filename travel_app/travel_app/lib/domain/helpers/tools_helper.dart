import 'dart:developer';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/global_components/message_dialog.dart';

class Tools {
  static String customDateFormater(
      {required DateTime date, required bool withHours}) {
    final DateFormat inputFormat =
        withHours ? DateFormat('dd/MM/yyyy HH:mm') : DateFormat('dd/MM/yyyy');
    final String formattedDate = inputFormat.format(date);

    return formattedDate;
  }

  Future<String?> getAssetsJsonAsString(String path) async {
    return rootBundle.loadString(path);
  }

  DateTime formatStringDateFromDatabase(String date) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateTime date1 = inputFormat.parse(date);
    return date1;
    // final DateFormat outputFormat = DateFormat('dd/MM/yyyy');
    // return DateTime.parse(outputFormat.format(date1));
  }

  DateTime formatDateForDatabase(String date) {
    final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final DateTime date1 = inputFormat.parse(date);

    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    return DateTime.parse(outputFormat.format(date1));
  }

  String formatStringDateToJson(String date) {
    final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final DateTime date1 = inputFormat.parse(date);

    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    final DateTime result = DateTime.parse(outputFormat.format(date1));
    return result.toString().split('.').first;
  }

  String formatDateTimeDateToJson(DateTime? date) {
    String res = '';
    if (date != null) {
      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      final DateTime result = DateTime.parse(outputFormat.format(date));
      res = result.toString().split('.').first;
    }
    return res;
  }

  String formatDateFromDatabase(String date) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateTime date1 = inputFormat.parse(date.split(' ').first);
    return DateFormat('dd/MM/yyyy').format(date1);
  }

  static String customHourFormatter(DateTime date) {
    final DateFormat inputFormat = DateFormat('HH:mm');
    final String formattedDate = inputFormat.format(date);

    return formattedDate;
  }

  void handleError(
      {required Map<String, dynamic> body, bool showError = true}) {
    if (body['message'] != null) {
      if (showError) {
        return showMessageDialog(
            title: 'Hata', body: body['message'] as String);
      } else {
        log(body['message'] as String);
      }
    } else {
      dynamic errorList;
      if (body['errors'] is List) {
        errorList = body['errors'] as List<dynamic>;
      } else {
        errorList = body['message'];
      }
      errorList = List.castFrom(errorList as List<dynamic>);
      if (errorList.isNotEmpty) {
        String message = '';
        if (errorList is List<Map<String, dynamic>>) {
          for (int i = 0; i < errorList.length; i++) {
            if (errorList[i].values is List) {
              for (int j = 0; j < errorList[i].values.length; j++) {
                final String val_ = errorList[i].values as String;
                message += '$val_.';
              }
            }
          }
          // ignore: unnecessary_type_check
        } else if (errorList is List) {
          for (final dynamic item in errorList) {
            String item_ = '[ERROR]\n';
            if (item is String) {
              item_ = item;
            } else if (item is Map<String, dynamic>) {
              for (final String key in item.keys) {
                if (item[key] is String) {
                  item_ += '${item[key]}\n';
                }
              }
            } else {
              item_ = '$item';
            }

            message += '$item_.';
          }
        }
        if (showError) {
          return showMessageDialog(title: 'Hata', body: message);
        } else {
          log(message);
        }
      } else {
        if (showError) {
          return showMessageDialog(
            title: 'Hata',
            body: 'Bir şeyler yanlış gitti!',
          );
        } else {
          log('Undefined error from handle error method');
        }
      }
    }
  }

  Future<void> openLink({required String link, bool inApp = true}) async {
    final Uri uri = Uri.parse(link);
    launchUrl(
      uri,
      mode: inApp ? LaunchMode.inAppWebView : LaunchMode.platformDefault,
    );
  }

  Future<void> openPDFLink({required String link, bool inApp = true}) async {
    final String googleDocsUrl =
        'https://docs.google.com/gview?embedded=true&url=${Uri.encodeQueryComponent(link)}';
    final Uri uri = Uri.parse(googleDocsUrl);
    try {
      await launchUrl(
        uri,
        mode: inApp ? LaunchMode.inAppWebView : LaunchMode.platformDefault,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  String generateGetRequest(String url, Map<String, dynamic> parameters) {
    final Uri uri = Uri.parse(url).replace(queryParameters: parameters);
    return uri.toString();
  }
}
