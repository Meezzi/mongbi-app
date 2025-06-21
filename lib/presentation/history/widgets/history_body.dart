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
  final double extendPadding = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      // 오버스크롤(튕김) 된 경우 보여줄 배경
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.5, 0.5, 1],
          colors: [
            Color(0xFFFCF8FF),
            Color(0xFFFCF8FF),
            Color(0xFF3B136B),
            Color(0xFF3B136B),
          ],
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
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // 캘린더쪽 배경
                    colors:
                        isActive
                            ? [Color(0xFF3B136B), Color(0xFF3B136B)]
                            : [Color(0xFFFCF8FF), Color(0xffE8D6FF)],
                  ),
                ),
                child: Padding(
                  key: calendarKey,
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: horizontalPadding + extendPadding,
                  ),
                  child: Column(
                    children: [
                      CalendarChangeButton(),
                      Calendar(horizontalPadding: horizontalPadding),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -extendPadding),
                child: HistoryList(
                  key: historyKey,
                  horizontalPadding: horizontalPadding,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
