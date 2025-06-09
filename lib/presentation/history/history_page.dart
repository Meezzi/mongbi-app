import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_drop_down_button.dart';
import 'package:mongbi_app/presentation/history/widgets/history_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final double horizontalPadding = 24;

  @override
  void initState() {
    super.initState();

    // 이거 동작 안하는 것 같은데?
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 배경 투명
        statusBarIconBrightness: Brightness.dark, // 아이콘 색: 어두운 색 (검정)
        statusBarBrightness: Brightness.light, // iOS용 설정
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 480
    // 768
    // 1280
    // 반응형이 비율인지 크기별인지

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text('모몽의 꿈 기록', style: Font.title20),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFDF8FF), Color(0xffEAC9FA)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    CalendarDropDownButton(),
                    Calendar(horizontalPadding: horizontalPadding),
                  ],
                ),
              ),
              HistoryList(horizontalPadding: horizontalPadding),
            ],
          ),
        ),
      ),
    );
  }
}
