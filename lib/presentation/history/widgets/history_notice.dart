import 'package:flutter/material.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/presentation/history/widgets/history_item.dart';

class HistoryNotice extends StatelessWidget {
  const HistoryNotice({
    super.key,
    required this.calendarState,
    required this.expandPaddingValue,
    required this.horizontalPadding,
  });
  final CalendarModel calendarState;
  final double expandPaddingValue;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    String noticeText = '';

    // 날짜 미선택 또는 기록 없음
    if (calendarState.selectedDay == null) {
      noticeText = '원하는 날짜를 선택해야 한다몽';
      return Container(
        padding: EdgeInsets.only(bottom: expandPaddingValue),
        child: Center(
          child: Text(
            noticeText,
            style: Font.title14.copyWith(color: Color(0xFFB273FF)),
          ),
        ),
      );
    } else if (calendarState.searchedHistory.isEmpty) {
      noticeText = '앗, 나한테 들려준 꿈이 없다몽';
      return Container(
        padding: EdgeInsets.only(bottom: expandPaddingValue),
        child: Center(
          child: Text(
            noticeText,
            style: Font.title14.copyWith(color: Color(0xFFB273FF)),
          ),
        ),
      );
    } else {
      final history = calendarState.searchedHistory.first;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.formatYearMonthDayWeek(calendarState.selectedDay!),
            style: Font.title14.copyWith(color: Colors.white),
          ),
          SizedBox(height: horizontalPadding),
          HistoryItem(label: '내가 꾼 꿈', content: history.dreamContent),
          HistoryItem(
            label: '몽비의 꿈 해석',
            content: history.dreamInterpretation,
            tagList: history.dreamKeywords,
          ),
          HistoryItem(
            label: '몽비의 심리 해석',
            content: history.psychologicalStateInterpretation,
            tagList: history.psychologicalStateKeywords,
          ),
          HistoryItem(label: '몽비의 한마디', content: history.mongbiComment),
        ],
      );
    }
  }
}
