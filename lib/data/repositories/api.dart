import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../domain/helpers/shared_preference.dart';
import '../../domain/helpers/tools_helper.dart';
import '../../domain/repositories/base_services.dart';
import '../../resources/config/app_logic.dart';
import '../models/chat_message.dart';
import '../models/chat_object.dart';
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
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    var result = false;
    try {
      final http.Response response = await http.post(
        Uri.parse('$domain/login'),
        body: convert.jsonEncode(
          <String, dynamic>{
            'email': email,
            'password': password,
          },
        ),
        headers: _Headers().getHeaderUnauth(),
      );
      final dynamic body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        result = true;
        return SharedPreference().setToken('Bearer ${body['token']}');
      } else {
        await SharedPreference().setToken(null);
        await SharedPreference().setUserId(null);
        Tools().handleError(body: body as Map<String, dynamic>);
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  @override
  Future<List<UserObject>> getAllUsers() async {
    String? token;
    token = await SharedPreference().getToken();
    final List<UserObject> result = [];

    if (token != null) {
      try {
        final http.Response response = await http.get(
          Uri.parse('$domain/user/get-all'),
          headers: _Headers().getHeaderWithAuthToken(token),
        );
        final dynamic body = convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          for (var object in body['data']) {
            result.add(UserObject.fromJson(object));
          }
        } else {
          await SharedPreference().setToken(null);
          await SharedPreference().setUserId(null);

          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return result;
  }

  @override
  Future<List<ChatObject>> getAllChats() async {
    String? token;
    token = await SharedPreference().getToken();
    final List<ChatObject> result = [];

    if (token != null) {
      try {
        final http.Response response = await http.get(
          Uri.parse('$domain/chats'),
          headers: _Headers().getHeaderWithAuthToken(token),
        );
        final dynamic body = convert.jsonDecode(response.body);
        if (response.statusCode == 200 && body != "[]") {
          for (var object in body['data']) {
            result.add(ChatObject.fromJson(object));
          }
        } else {
          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return result;
  }

  @override
  Future<ChatObject?> createNewChat(
      {required int userOneId, required int userTwoId}) async {
    String? token;
    token = await SharedPreference().getToken();
    ChatObject? result;

    if (token != null) {
      try {
        final http.Response response = await http.post(
          Uri.parse('$domain/chats'),
          headers: _Headers().getHeaderWithAuthToken(token),
          body: convert.jsonEncode(
            <String, dynamic>{
              'user_one_id': userOneId,
              'user_two_id': userTwoId,
            },
          ),
        );
        final dynamic body = convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          result = ChatObject.fromJson(body['data'] as Map<String, dynamic>);
        } else {
          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return result;
  }

  @override
  Future<UserObject?> getOtherUser({required int userId}) async {
    String? token;
    token = await SharedPreference().getToken();

    if (token != null) {
      try {
        final http.Response response = await http.get(
          Uri.parse('$domain/user/$userId'),
          headers: _Headers().getHeaderWithAuthToken(token),
        );
        final dynamic body = convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          return UserObject.fromJson(
            body['data'] as Map<String, dynamic>,
          );
        } else {
          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  @override
  Future<List<MessageObject>> getChatMessages(
      {required int chatId, int? page}) async {
    String? token;
    token = await SharedPreference().getToken();
    List<MessageObject> result = [];

    if (token != null) {
      try {
        final http.Response response = await http.get(
          Uri.parse('$domain/chats/$chatId/messages?page=$page'),
          headers: _Headers().getHeaderWithAuthToken(token),
        );

        final dynamic body = convert.jsonDecode(response.body);

        if (response.statusCode == 200) {
          for (var object in body['data']) {
            result.add(MessageObject.fromJson(object));
          }
        } else {
          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return result;
  }

  @override
  Future<bool> broadcastAuthentication(
      {required String channelName, required String socketID}) async {
    String? token;
    token = await SharedPreference().getToken();
    bool result = false;

    if (token != null) {
      try {
        final http.Response response = await http.post(
          Uri.parse('$domain/broadcasting/auth'),
          headers: _Headers().getHeaderWithAuthToken(token),
          body: convert.jsonEncode(
            <String, dynamic>{
              'channel_name': channelName,
              'socket_id': socketID,
            },
          ),
        );

        final dynamic body = convert.jsonDecode(response.body);

        if (response.statusCode == 200) {
          final String token = '${body['auth']}';
          SharedPreference().setBroadcastToken(token);
          result = true;
        } else {
          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return result;
  }

  @override
  Future<bool> sendMessage(
      {required String message,
      required int receiverId,
      required String socketId}) async {
    String? token;
    token = await SharedPreference().getToken();
    bool result = false;

    if (token != null) {
      try {
        final http.Response response = await http.post(
          Uri.parse('$domain/message/send'),
          headers: {
            'Authorization': token,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'X-Socket-ID': socketId,
          },
          body: convert.jsonEncode(
            <String, dynamic>{
              'content': message,
              'receiver_id': receiverId,
            },
          ),
        );

        final dynamic body = convert.jsonDecode(response.body);

        if (response.statusCode == 200) {
          result = true;
        } else {
          Tools().handleError(body: body as Map<String, dynamic>);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return result;
  }
}
