<<<<<<< HEAD
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
=======
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

<<<<<<< HEAD
  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
=======
  /// 초기화
  Future<void> init() async {
    tz.initializeTimeZones();
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
<<<<<<< HEAD
        // 예: context.go('/remind');
=======
        // 알림 클릭 시 동작 (예: 라우팅)
        // navigatorKey.currentState?.pushNamed('/remind');
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)
      },
    );
  }

<<<<<<< HEAD
  Future<void> openExactAlarmSettingsIfNeeded() async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      );
      await intent.launch();
    }
  }

=======
  /// 알림 권한 요청 (iOS + Android)
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)
  Future<bool> requestNotificationPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    final status = await Permission.notification.request();
    return status.isGranted;
  }

<<<<<<< HEAD
  Future<void> showInstantNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      '테스트 알림',
      '이건 즉시 표시되는 알림입니다',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test',
          channelDescription: '즉시 알림 테스트 채널',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

=======
  /// 매일 특정 시간에 알림 예약
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)
  Future<void> scheduleDailyReminder(TimeOfDay time) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

<<<<<<< HEAD
    final tzTime = _nextInstanceOfTime(scheduledTime);

    const androidDetails = AndroidNotificationDetails(
      'daily_reminder',
      'Daily Reminder',
      channelDescription: '몽비 리마인드 알림 채널',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        '설정하신 리마인드 시간이예요 🌙',
        contentTitle: '<b>몽비</b>',
        htmlFormatContent: true,
        htmlFormatContentTitle: true,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '몽비',
      '설정하신 리마인드 시간이예요 🌙',
      tzTime,
      const NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

=======
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '몽비가 인사드려요!',
      '설정하신 리마인드 시간이예요 🌙',
      _nextInstanceOfTime(scheduledTime),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          channelDescription: '몽비 리마인드 알림 채널',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // ✅ 필수
    );
  }

  /// 다음 알림 시간 계산 (지났으면 내일로)
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)
  tz.TZDateTime _nextInstanceOfTime(DateTime dateTime) {
    final tzNow = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
<<<<<<< HEAD

    if (scheduled.isBefore(tzNow)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

=======
    if (scheduled.isBefore(tzNow)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
>>>>>>> a0bfb6b (feat: 권한 추가 및 뷰모델 기능 추가)
    return scheduled;
  }
}
