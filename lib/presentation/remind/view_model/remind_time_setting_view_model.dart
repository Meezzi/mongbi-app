import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:android_intent_plus/android_intent.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  /// 초기화
  Future<void> init() async {
    print('[🔔 알림 초기화] 초기화 시작');
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        print('[📬 알림 클릭됨] payload: ${details.payload}');
        // 예: context.go('/remind');
      },
    );
    print('[✅ 알림 초기화 완료]');
  }

  Future<void> openExactAlarmSettingsIfNeeded() async {
    if (Platform.isAndroid) {
      print('[⚙️ 설정 이동] 정확한 알람 권한 요청 화면으로 이동');
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      );
      await intent.launch();
    }
  }

  /// 알림 권한 요청 (iOS + Android)
  Future<bool> requestNotificationPermission() async {
    print('[🔐 권한 요청] 알림 권한 요청 시작');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    final status = await Permission.notification.request();
    print('[🔐 권한 상태] ${status.isGranted ? "허용됨" : "거부됨"}');
    return status.isGranted;
  }

  /// 즉시 알림 표시
  Future<void> showInstantNotification() async {
    print('[🚨 즉시 알림] 테스트 알림 호출');
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

  /// 매일 특정 시간에 알림 예약
  Future<void> scheduleDailyReminder(TimeOfDay time) async {
    print('[🗓️ 예약 시도] 설정된 시간: ${time.hour}:${time.minute}');
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final tzTime = _nextInstanceOfTime(scheduledTime);
    print('[📌 예약 알림 시간(TZ)] $tzTime');
    print('[📌 예약 알림 시간(Local)] ${tzTime.toLocal()}');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '몽비가 인사드려요!',
      '설정하신 리마인드 시간이예요 🌙',
      tzTime,
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    print('[✅ 예약 완료] 알림이 등록되었습니다.');
  }

  /// 다음 알림 시간 계산 (지났으면 내일로)
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
      print('[⏩ 시간 조정] 이미 지난 시간입니다. 다음 날로 설정합니다.');
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
