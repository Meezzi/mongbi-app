import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mongbi_app/presentation/auth/social_login_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  // 캘린더 한글화
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '323f653e5d7d80bf1551baeb82d49e23',
    javaScriptAppKey: '5e37c7d2e75e4045e04162e2d401993b',
  );
  
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NanumSquareRound'),
      home: SocialLoginPage(),
    );
  }
}
