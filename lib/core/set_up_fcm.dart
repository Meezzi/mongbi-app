import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongbi_app/firebase_optiopns.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';

// 🔔 로컬 알림 초기화용 싱글톤
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    await _plugin.initialize(initSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }
}

// 📩 백그라운드 메시지 핸들러
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().init();

  print("📩 Handling a background message: ${message.messageId}");
  await NotificationService().showNotification(
    id: message.hashCode,
    title: message.notification?.title ?? 'No Title',
    body: message.notification?.body ?? 'No Body',
  );
}

// ✅ FCM 초기 설정
Future<void> setupFCM() async {
  await NotificationService().init(); // 로컬 알림 초기화

  final fcm = FirebaseMessaging.instance;

  await fcm.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  final fcmToken = await fcm.getToken();
  print('FCM Token: $fcmToken');

  fcm.onTokenRefresh.listen((newFcmToken) {
    print('New FCM Token: $newFcmToken');
    // TODO: 서버에 새로운 토큰 전송
  });

  // 💬 포그라운드 메시지 처리
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('📥 Foreground message received!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      await NotificationService().showNotification(
        id: message.hashCode,
        title: message.notification!.title ?? 'No Title',
        body: message.notification!.body ?? 'No Body',
      );
    }
  });

  // 💤 백그라운드 메시지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
