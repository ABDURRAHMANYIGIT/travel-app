import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  NotificationHelper();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotifications = BehaviorSubject<String?>();

  /// create dummy notification details if not sent from the app to prevent error
  Future<NotificationDetails> _notificationDetails({
    LocalNotificationChannelInfo? channelInfo,
  }) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
        channelInfo == null
            ? 'channelName'
            : channelInfo.channelName ?? 'channelName',
        channelDescription: channelInfo == null
            ? 'channelDescription'
            : channelInfo.channelDescription ?? 'channelDescription',
        importance: Importance.max,
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  Future<void> init({
    bool initScheduled = false,
    Future<dynamic> Function(String?)? onSelectNotification,
    bool iosPermission = false,
  }) async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iOS = DarwinInitializationSettings(
      requestAlertPermission: iosPermission,
      requestBadgePermission: iosPermission,
      requestSoundPermission: iosPermission,
    );
    final InitializationSettings settings =
        InitializationSettings(android: android, iOS: iOS);

    final NotificationAppLaunchDetails? details =
        await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.notificationResponse?.payload);
    }

    await _notifications.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse details) {
        onNotifications.add(details.payload);
      },
    );

    if (initScheduled) {
      // tz.initializeTimeZones();
      tz.initializeTimeZones();
      final String locationName =
          await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  Future<dynamic> showNotification(
          LocalNotificationInfo currentNotification) async =>
      _notifications.show(
        currentNotification.id == null ? 100 : currentNotification.id!,
        currentNotification.title,
        currentNotification.body,
        await _notificationDetails(
          channelInfo: LocalNotificationChannelInfo(
            channelId: currentNotification.channelId,
            channelName: currentNotification.channelName,
            channelDescription: currentNotification.channelDescription,
          ),
        ),
        payload: currentNotification.payload,
      );

  ///show notification in future (eg. 15 seconds)
  ///
  ///[givenTime] is the time when notification will be fired
  Future<dynamic> showScheduledNotification({
    required LocalNotificationInfo currentNotification,
    required DateTime givenTime,
    NotificationDetails? currentNotificationDetails,
  }) async {
    _notifications.zonedSchedule(
      currentNotification.id == null ? 100 : currentNotification.id!,
      currentNotification.title,
      currentNotification.body,
      tz.TZDateTime.from(givenTime, tz.local),
      currentNotificationDetails ??
          await _notificationDetails(
            channelInfo: LocalNotificationChannelInfo(
              channelId: currentNotification.channelId,
              channelName: currentNotification.channelName,
              channelDescription: currentNotification.channelDescription,
            ),
          ),
      payload: currentNotification.payload ?? 'noPayload',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// schedule a notification at given time and week day
  ///
  /// [weekDay] is the integer value of the day in the week (1 for monday,7 for sunday)
  ///
  ///[givenTime] is the time when notification will be fired
  Future<void> scheduleWeeklyGivenDayAndTimeNotification({
    required LocalNotificationInfo currentNotification,
    required DateTime givenTime,
    required int weekDay,
    NotificationDetails? currentNotificationDetails,
  }) async {
    await _notifications.zonedSchedule(
      currentNotification.id == null ? 100 : currentNotification.id!,
      currentNotification.title,
      currentNotification.body,
      _nextInstanceOfGivenTimeAtGivenDay(
          givenTime: givenTime, weekday: weekDay),
      currentNotificationDetails ??
          await _notificationDetails(
            channelInfo: LocalNotificationChannelInfo(
              channelId: currentNotification.channelId,
              channelName: currentNotification.channelName,
              channelDescription: currentNotification.channelDescription,
            ),
          ),
      payload: currentNotification.payload ?? 'noPayload',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _nextInstanceOfGivenTimeAtGivenDay(
      {required DateTime givenTime, required int weekday}) {
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, givenTime.year,
        givenTime.month, givenTime.day, givenTime.hour, givenTime.minute);
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// schedule a notification at given time
  ///
  ///[givenTime] is the time when notification will be fired
  Future<dynamic> scheduleDailyGivenTime({
    required LocalNotificationInfo currentNotification,
    required DateTime givenTime,
    NotificationDetails? currentNotificationDetails,
  }) async {
    _notifications.zonedSchedule(
      currentNotification.id == null ? 100 : currentNotification.id!,
      currentNotification.title,
      currentNotification.body,
      tz.TZDateTime.from(givenTime, tz.local),
      currentNotificationDetails ??
          await _notificationDetails(
            channelInfo: LocalNotificationChannelInfo(
              channelId: currentNotification.channelId,
              channelName: currentNotification.channelName,
              channelDescription: currentNotification.channelDescription,
            ),
          ),
      payload: currentNotification.payload ?? 'noPayload',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<dynamic> showScheduledNotificationDayWeek({
    required LocalNotificationInfo currentNotification,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        currentNotification.id == null ? 100 : currentNotification.id!,
        currentNotification.title,
        currentNotification.body,
        _scheduleDaily(hour: scheduledDate.hour, minute: scheduledDate.minute),
        await _notificationDetails(
          channelInfo: LocalNotificationChannelInfo(
            channelId: currentNotification.channelId,
            channelName: currentNotification.channelName,
            channelDescription: currentNotification.channelDescription,
          ),
        ),
        payload: currentNotification.payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  Future<void> scheduleWeeklyMorningNotification({
    required LocalNotificationInfo currentNotification,
    TimeOfDay? wakeUpTime = const TimeOfDay(hour: 8, minute: 30),
  }) async {
    await _notifications.zonedSchedule(
      currentNotification.id == null ? 100 : currentNotification.id!,
      currentNotification.title,
      currentNotification.body,
      _nextInstanceOfTenAM(wakeUpTime!),
      await _notificationDetails(
        channelInfo: LocalNotificationChannelInfo(
          channelId: currentNotification.channelId,
          channelName: currentNotification.channelName,
          channelDescription: currentNotification.channelDescription,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> scheduleWeeklyWakeupTimeNotification({
    required LocalNotificationInfo currentNotification,
    required DateTime wakeupTime,
    NotificationDetails? currentNotificationDetails,
  }) async {
    await _notifications.zonedSchedule(
      currentNotification.id == null ? 100 : currentNotification.id!,
      currentNotification.title,
      currentNotification.body,
      _nextInstanceOfWakeupTimeAtMonday(wakeupTime),
      currentNotificationDetails ??
          await _notificationDetails(
            channelInfo: LocalNotificationChannelInfo(
              channelId: currentNotification.channelId,
              channelName: currentNotification.channelName,
              channelDescription: currentNotification.channelDescription,
            ),
          ),
      payload: currentNotification.payload ?? 'noPayload',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(TimeOfDay wakeUpTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, wakeUpTime.hour, wakeUpTime.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfWakeupTimeAtMonday(DateTime wakeUpTime) {
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, wakeUpTime.year,
        wakeUpTime.month, wakeUpTime.day, wakeUpTime.hour, wakeUpTime.minute);
    while (scheduledDate.weekday != DateTime.monday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _scheduleDaily({required int hour, required int minute}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  Future<dynamic> showScheduledNotificationWeek({
    required LocalNotificationInfo currentNotification,
    // required DateTime scheduledDate,
    TimeOfDay? wakeUpTime = const TimeOfDay(hour: 8, minute: 30),
  }) async =>
      _notifications.zonedSchedule(
        currentNotification.id == null ? 1 : currentNotification.id!,
        currentNotification.title,
        currentNotification.body,
        _scheduleWeekly(
          tz.TZDateTime.local(1, 7),
          days: <int>[
            DateTime.monday,
          ],
        ),
        await _notificationDetails(
          channelInfo: LocalNotificationChannelInfo(
            channelId: currentNotification.channelId,
            channelName: currentNotification.channelName,
            channelDescription: currentNotification.channelDescription,
          ),
        ),
        payload: currentNotification.payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );

  tz.TZDateTime _scheduleWeekly(tz.TZDateTime time, {required List<int> days}) {
    tz.TZDateTime scheduledDate =
        _scheduleDaily(hour: time.hour, minute: time.minute);
    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  void cancelNotificationWithId(int id) => _notifications.cancel(id);

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// delete channel with the given [channelId]
  Future<void> deleteNotificationChannel(String channelId) async {
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(channelId);
  }
}

class LocalNotificationHelpers {
  LocalNotificationHelpers();

  ///show notification with small icon
  Future<NotificationDetails> notificationDetailsImageLargeIcon({
    required String imageNameAtDrawable,
    required String imageNameAtAsset,
    LocalNotificationChannelInfo? channelInfo,
    String? imageNameAtDrawableLargeIcon,
  }) async {
    final StyleInformation styleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap(imageNameAtDrawable),
      hideExpandedLargeIcon: true,
    );
    //43 characters long
    final String attachmentPicturePath =
        await getImageFilePathFromAssets(imageNameAtAsset);

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
        channelInfo == null
            ? 'channelName'
            : channelInfo.channelName ?? 'channelName',
        channelDescription: channelInfo == null
            ? 'channelDescription'
            : channelInfo.channelDescription ?? 'channelDescription',
        largeIcon: imageNameAtDrawableLargeIcon == null
            ? null
            : DrawableResourceAndroidBitmap(imageNameAtDrawableLargeIcon),
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
      iOS: DarwinNotificationDetails(
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment(attachmentPicturePath),
        ],
        threadIdentifier: channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
      ),
    );
  }

  Future<NotificationDetails> notificationDetailsBigTextLargeIcon({
    required String imageNameAtAsset,
    LocalNotificationChannelInfo? channelInfo,
    String? imageNameAtDrawableLargeIcon,
    String? bigText,
  }) async {
    final StyleInformation styleInformation = BigTextStyleInformation(
      bigText ?? '',
    );

    final String attachmentPicturePath =
        await getImageFilePathFromAssets(imageNameAtAsset);

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
        channelInfo == null
            ? 'channelName'
            : channelInfo.channelName ?? 'channelName',
        channelDescription: channelInfo == null
            ? 'channelDescription'
            : channelInfo.channelDescription ?? 'channelDescription',
        largeIcon: imageNameAtDrawableLargeIcon == null
            ? null
            : DrawableResourceAndroidBitmap(imageNameAtDrawableLargeIcon),
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
      iOS: DarwinNotificationDetails(
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment(attachmentPicturePath),
        ],
        threadIdentifier: channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
      ),
    );
  }

  ///https://stackoverflow.com/questions/68764433/how-to-add-local-image-to-flutter-local-notifications
  ///
  ///show notification with small and large icon
  Future<NotificationDetails> notificationDetailsImageWithLargeIcon({
    required String imageNameAtDrawable,
    required String imageNameAtDrawableLarge,
    required String imageNameAtAsset,
    String? icon,
    LocalNotificationChannelInfo? channelInfo,
  }) async {
    final StyleInformation styleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap(imageNameAtDrawable),
      largeIcon: DrawableResourceAndroidBitmap(imageNameAtDrawableLarge),
    );

    final String attachmentPicturePath =
        await getImageFilePathFromAssets(imageNameAtAsset);

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
        channelInfo == null
            ? 'channelName'
            : channelInfo.channelName ?? 'channelName',
        channelDescription: channelInfo == null
            ? 'channelDescription'
            : channelInfo.channelDescription ?? 'channelDescription',
        importance: Importance.max,
        icon: icon,
        styleInformation: styleInformation,
      ),
      iOS: DarwinNotificationDetails(
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment(attachmentPicturePath),
        ],
        threadIdentifier: channelInfo == null
            ? 'channelId'
            : channelInfo.channelId ?? 'channelId',
      ),
    );
  }

  Future<String> getImageFilePathFromAssets(String asset) async {
    final ByteData byteData = await rootBundle.load(asset);

    final File file = File(
        '${(await getTemporaryDirectory()).path}/${asset.split('/').last}');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file.path;
  }

  ///https://github.com/MaikuB/flutter_local_notifications/issues/1166#issuecomment-849715825
  Future<String> copyFromAssetsToAppDir(String fileName) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = '${dir.path}/$fileName';
    final File file = File(path);

    // ignore: avoid_slow_async_io
    if (await file.exists()) {
      return path;
    }
    //assets can be removed, only fileName can be sent
    final ByteData imageBytes = await rootBundle.load(fileName);
    final Uint8List bytes = imageBytes.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    return path;
  }
}

class LocalNotificationChannelInfo {
  LocalNotificationChannelInfo({
    this.channelId,
    this.channelName,
    this.channelDescription,
  });
  String? channelId;
  String? channelName;
  String? channelDescription;
}

class LocalNotificationInfo {
  LocalNotificationInfo({
    this.id = 0,
    this.title,
    this.body,
    this.payload,
    this.channelId,
    this.channelName,
    this.channelDescription,
  });
  int? id;
  String? title;
  String? body;
  String? payload;
  String? channelId;
  String? channelName;
  String? channelDescription;
}
