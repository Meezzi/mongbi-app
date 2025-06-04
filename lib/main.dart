import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mongbi_app/presentation/history/history_page.dart';

void main() async {
  // 캘린더 한글화
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HistoryPage());
  }
}
