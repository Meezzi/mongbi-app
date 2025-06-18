import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/history/history_key/history_key.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_change_button.dart';
import 'package:mongbi_app/presentation/history/widgets/history_list.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    super.key,
    required this.isActive,
    required this.onScroll,
    required this.calendarState,
    required this.horizontalPadding,
  });

  final bool isActive;
  final void Function() onScroll;
  final CalendarModel calendarState;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: double.infinity,
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              isActive
                  ? [Color(0xFF3B136B), Color(0xFF3B136B)]
                  : [Color(0xffFDF8FF), Color(0xffEAC9FA)],
        ),
      ),
      child: NotificationListener(
        onNotification: (notification) {
          // 스크롤시 기록의 위치와 앱바를 비교하여 배경 변경
          if (notification is ScrollUpdateNotification) {
            onScroll();
          }

          return false;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                key: calendarKey,
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: horizontalPadding,
                ),
                child: Column(
                  children: [
                    CalendarChangeButton(),
                    Calendar(horizontalPadding: horizontalPadding),
                  ],
                ),
              ),
              HistoryList(
                key: historyKey,
                horizontalPadding: horizontalPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
