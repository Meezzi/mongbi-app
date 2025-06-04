import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '몽비의 꿈 기록',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Container(
          color: Colors.amberAccent,
          child: TableCalendar(
            locale: 'ko_KR',
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(DateTime.now().year, 1, 31),
            lastDay: DateTime.utc(DateTime.now().year, 12, 31),
          ),
        ),
      ),
    );
  }
}
