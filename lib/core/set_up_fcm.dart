import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupFCM() async {
  await Firebase.initializeApp();
  // You may set the permission requests to "provisional" which allows the user to choose what type
  // of notifications they would like to receive once the user receives a notification.
  final notificationSettings = await FirebaseMessaging.instance
      .requestPermission(provisional: true);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('✅');
  print(fcmToken);
  print('✅');

  /*

  final notificationSettings = await FirebaseMessaging.instance
      .requestPermission(provisional: true);

  // ✅ 애플일 경우에 필요한 코드 For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
  }

   */

  // ✅ 이전 코드
  // await Firebase.initializeApp();

  // final messaging = FirebaseMessaging.instance;
  // // iOS 권한 요청
  // NotificationSettings settings = await FirebaseMessaging.instance
  //     .requestPermission(alert: true, badge: true, sound: true);

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('🔔 알림 권한 승인됨');

  //   // ✅ FCM 토큰 가져오기
  //   String? apnsToken = await messaging.getAPNSToken();
  //   print('🔑 APNs Token: $apnsToken');
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print('📲 FCM Token: $token');

  //   // 👉 이후 서버에 등록 등 원하는 처리
  // } else {
  //   print('❌ 알림 권한 거부됨');
  // }
}
