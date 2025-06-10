import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mongbi_app/presentation/auth/social_login_page.dart';
import 'package:mongbi_app/presentation/history/history_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  // 캘린더 한글화
  await initializeDateFormatting();

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
