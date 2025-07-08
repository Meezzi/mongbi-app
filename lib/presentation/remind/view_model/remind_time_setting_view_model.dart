import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:app_settings/app_settings.dart';
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

  bool _isTimezoneInitialized = false;

  Future<void> init() async {
    if (!_isTimezoneInitialized) {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
      _isTimezoneInitialized = true;
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  /// 정확한 알람 권한 설정 (Android 12+)
  Future<void> openExactAlarmSettingsIfNeeded() async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      );
      await intent.launch();
    }
  }

  /// 앱 설정 화면으로 이동 (알림 영구 거부 시)
  Future<void> openAppSettingsIfNeeded() async {
    await AppSettings.openAppSettings();
  }

  /// 알림 권한 요청
  Future<bool> requestNotificationPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.notification.status;

      if (status.isGranted) return true;

      final result = await Permission.notification.request();
      return result.isGranted;
    }

    // Android
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// 매일 알림 스케줄링
  Future<void> scheduleDailyReminder(TimeOfDay time) async {
    // 👇 알림 예약 전에 init 보장
    await init();

    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final tzTime = _nextInstanceOfTime(scheduledTime);

    const androidDetails = AndroidNotificationDetails(
      'daily_reminder',
      'Daily Reminder',
      channelDescription: '몽비 리마인드 알림 채널',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'ic_mongbi_icon',
      styleInformation: BigTextStyleInformation(
        '잘잤어? 꿈을 꿨다면 나에게 말해줘몽!',
        contentTitle: '<b>몽비</b>',
        htmlFormatContent: true,
        htmlFormatContentTitle: true,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '몽비',
      '잘잤어? 꿈을 꿨다면 나에게 말해줘몽!',
      tzTime,
      const NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

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

    if (scheduled.isBefore(tzNow)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelReminderNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
