import 'package:flutter/material.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/remove_html_tags.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/presentation/history/widgets/history_item.dart';

class HistoryNotice extends StatefulWidget {
  const HistoryNotice({
    super.key,
    required this.calendarState,
    required this.expandPaddingValue,
    required this.horizontalPadding,
    required this.controller,
  });

  final CalendarModel calendarState;
  final double expandPaddingValue;
  final double horizontalPadding;
  final ScrollController controller;

  @override
  State<HistoryNotice> createState() => _HistoryNoticeState();
}

class _HistoryNoticeState extends State<HistoryNotice> {
  final itemKeyList = List.generate(5, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    String noticeText = '';

    // 날짜 미선택 또는 기록 없음
    if (widget.calendarState.selectedDay == null) {
      noticeText = '원하는 날짜를 선택해야 한다몽';
      return Container(
        padding: EdgeInsets.only(bottom: widget.expandPaddingValue),
        child: Center(
          child: Text(
            noticeText,
            style: Font.title14.copyWith(color: Color(0xFFB273FF)),
          ),
        ),
      );
    } else if (widget.calendarState.searchedHistory.isEmpty) {
      noticeText = '앗, 나한테 들려준 꿈이 없다몽';
      return Container(
        padding: EdgeInsets.only(bottom: widget.expandPaddingValue),
        child: Center(
          child: Text(
            noticeText,
            style: Font.title14.copyWith(color: Color(0xFFB273FF)),
          ),
        ),
      );
    } else {
      final history = widget.calendarState.searchedHistory.first;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.formatYearMonthDayWeek(
              widget.calendarState.selectedDay!,
            ),
            style: Font.title14.copyWith(color: Colors.white),
          ),
          SizedBox(height: widget.horizontalPadding),
          HistoryItem(
            key: itemKeyList[0],
            nextItemKey: itemKeyList[1],
            label: '내가 꾼 꿈',
            content: history.dreamContent,
            controller: widget.controller,
          ),
          HistoryItem(
            key: itemKeyList[1],
            nextItemKey: itemKeyList[2],
            label: '몽비의 꿈 해석',
            content: history.dreamInterpretation,
            tagList: history.dreamKeywords,
            controller: widget.controller,
          ),
          HistoryItem(
            key: itemKeyList[2],
            nextItemKey: itemKeyList[3],
            label: '몽비의 심리 해석',
            content: history.psychologicalStateInterpretation,
            tagList: history.psychologicalStateKeywords,
            controller: widget.controller,
          ),
          HistoryItem(
            key: itemKeyList[3],
            nextItemKey: itemKeyList[4],
            label: '몽비의 한마디',
            content: history.mongbiComment,
            controller: widget.controller,
          ),
          if (history.challengeDesc != null)
            HistoryItem(
              key: itemKeyList[4],
              label: '몽비의 선물',
              content: removeHtmlTags(history.challengeDesc!),
              isChallenge: true,
              challengeType: history.challengeType!,
              challengeStatus: history.challengeStatus!,
              controller: widget.controller,
            ),
        ],
      );
    }
  }
}
