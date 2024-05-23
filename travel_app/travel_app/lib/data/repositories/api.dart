import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../domain/helpers/shared_preference.dart';
import '../../domain/helpers/tools_helper.dart';
import '../../domain/repositories/base_services.dart';
import '../../resources/config/app_logic.dart';
import '../models/collection.dart';
import '../models/user_object.dart';

part 'headers.dart';
// import 'package:firebase_storage/firebase_storage.dart';

enum AuthProblems { usernotfound, passwordnotvalid, networkerror }

class API implements BaseServices {
  factory API() => _instance;
  API._internal();
  String domain = AppLogic().getLocalPath();
  static final API _instance = API._internal();

  @override
  Future<int> getExample() {
    return Future<int>.delayed(
      const Duration(seconds: 4),
      () {
        return 4;
      },
    );
  }

  @override
  Future<UserObject?> getUser() async {
    String? token;
    token = await SharedPreference().getToken();

    if (token != null) {
      try {
        final http.Response response = await http.get(
          Uri.parse('$domain/user/get-user'),
          headers: _Headers().getHeaderWithAuthToken(token),
        );
        final dynamic body = convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          return UserObject.fromJson(
            body['data'] as Map<String, dynamic>,
          );
        } else {
          await SharedPreference().setToken(null);
          await SharedPreference().setUserId(null);

          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  @override
  Future<List<CollectionObject>> getCollections({String? languageCode}) async {
    final List<CollectionObject> result = <CollectionObject>[];
    try {
      final Uri endpoint = Uri.parse('$domain/level/get-levels');
      if (languageCode != null) {
        endpoint.replace(
          queryParameters: <String, String>{'language_code': languageCode},
        );
      }
      final http.Response response = await http.get(
        endpoint,
        headers: _Headers().getHeaderUnauth(),
      );

      final dynamic body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (final dynamic element in body['data'] as List<dynamic>) {
          result
              .add(CollectionObject.fromJson(element as Map<String, dynamic>));
        }
      } else {
        Tools().handleError(body: body as Map<String, dynamic>);
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
