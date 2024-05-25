import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void _onDidReceiveBackgroundNotificationResponseHandle(
    NotificationResponse notificationDetails) {}

class FCMHelper {
  factory FCMHelper() {
    return _fcmHelper;
  }
  FCMHelper._();
  static final FCMHelper _fcmHelper = FCMHelper._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token;
  NotificationSettings? settings;
  bool isInitDone = false;

  StreamController<dynamic>? streamController;
  StreamController<dynamic>? titleController;
  StreamController<dynamic>? bodyController;

  Future<void> init() async {
    if (isInitDone == true) {
      return;
    }
    settings = await _firebaseMessaging.getNotificationSettings();
    try {
      token = await _firebaseMessaging.getToken();
      log('FCMHelper - Token: $token');
    } on Exception catch (e, stacktrace) {
      log(stacktrace.toString());
    }
    isInitDone = true;
    //With this token you can test it easily on your phone
    streamController = StreamController<String>.broadcast();
    titleController = StreamController<String>.broadcast();
    bodyController = StreamController<String>.broadcast();

    //When app is in Foreground state
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamController?.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamController?.sink.add(message.data['notification']);
        }
        // Or do other work.
        if (message.notification != null) {
          titleController?.sink.add(message.notification!.title ?? '');
          bodyController?.sink.add(message.notification!.body ?? '');
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.containsKey('key')) {
        // final bool? isSentKey = message.data["key"] == "sent_key";
        // final String userId = message.data["userId"] as String;
        // Get.to(NotificationScreen(isMatched: isMatch, focusUserId: userId));
        // if (isMatch!) {
        //   // Get.to(() => NotificationMatchScreen(
        //   //       focusUserId: userId,
        //   //     ));
        // } else {
        //   // Get.to(() => NotificationLikesScreen(
        //   //       focusUserId: userId,
        //   //     ));
        // }
      }
    });

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      await _localNotificationPermission();
    }
    subscribeTopic('all');
    final NotificationSettings _settings =
        await _firebaseMessaging.requestPermission();
    settings = _settings;
    log('FCM Helper - request permission - ${_settings.authorizationStatus == AuthorizationStatus.authorized}');
    return isPermissionAllowed();
  }

  Future<void> subscribeTopic(String topic) async {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unSubscribeTopic(String topic) async {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  ///Since iOS not showing app Notification section in phone settings
  Future<void> _localNotificationPermission() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponseHandle,
      // onSelectNotification: (_) {},
    );
  }

  Future<String?> getToken() async {
    return _firebaseMessaging.getToken();
  }

  bool isPermissionAllowed() {
    bool result = false;
    if (settings != null) {
      if (settings!.authorizationStatus == AuthorizationStatus.authorized) {
        log('FCM Helper - permission allowed - true');
        result = true;
      } else {
        log('FCM Helper - permission allowed - false');
      }
    }
    return result;
  }

  Stream<dynamic> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  void dispose() {
    token = null;
    isInitDone = false;
    streamController?.close();
    bodyController?.close();
    titleController?.close();
  }
}

//intentionally
Future<void> onBackgroundMessage(RemoteMessage message) async {
  if (message.data.containsKey('data')) {
    // Handle data message
    // final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    // final notification = message.data['notification'];
  }
  // Or do other work.
}
