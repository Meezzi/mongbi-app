import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mongbi_app/firebase_options.dart';


class NotificationService {
  NotificationService._internal();
  factory NotificationService() => _instance;
  static final NotificationService _instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iOSSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );
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

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().init();


  if (message.notification == null) {
    await NotificationService().showNotification(
      id: message.hashCode,
      title: message.data['title'] ?? 'No Title',
      body: message.data['body'] ?? 'No Body',
    );
  }
}

Future<void> setupFCM() async {
  await NotificationService().init();

  final fcm = FirebaseMessaging.instance;

  await fcm.requestPermission(alert: true, badge: true, sound: true);



  fcm.onTokenRefresh.listen((newFcmToken) {
    // TODO: 서버에 새로운 토큰 전송
  });

  FirebaseMessaging.onMessage.listen((message) async {

    if (message.notification == null) {
      await NotificationService().showNotification(
        id: message.hashCode,
        title: message.data['title'] ?? 'No Title',
        body: message.data['body'] ?? 'No Body',
      );
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
