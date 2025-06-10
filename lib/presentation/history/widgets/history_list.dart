import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/presentation/history/history_key/history_key.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/presentation/history/widgets/history_item.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class HistoryList extends ConsumerStatefulWidget {
  const HistoryList({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  ConsumerState<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends ConsumerState<HistoryList> {
  double? expandPaddingValue;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final deviceSize = MediaQuery.of(context).size;
      final devicePadding = MediaQuery.of(context).padding;
      final appBarHeight = getWidgetInfo(appBarKey)?.size.height ?? 0;
      final naviHeight = getWidgetInfo(naviKey)?.size.height ?? 0;
      final calendarHeight = getWidgetInfo(calendarKey)?.size.height ?? 0;
      final noticeHeight = getWidgetInfo(noticeKey)?.size.height ?? 0;

      setState(() {
        expandPaddingValue =
            deviceSize.height -
            devicePadding.top -
            appBarHeight -
            naviHeight -
            calendarHeight -
            noticeHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarViewModelProvider);

    return Container(
      key: noticeKey,
      padding:
          calendarState.searchedHistory.isEmpty
              ? EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding,
                vertical: 40,
              )
              : EdgeInsets.all(widget.horizontalPadding),
      decoration: BoxDecoration(
        color: Color(0xFF3B136B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: historyWidget(calendarState),
    );
  }

  Widget historyWidget(CalendarModel calendarState) {
    String noticeText;

    // 날짜 미선택 또는 기록 없음
    if (calendarState.selectedDay == null) {
      noticeText = '원하는 날짜를 선택해야 한다몽';
      return Container(
        padding: EdgeInsets.only(bottom: expandPaddingValue ?? 0),
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
        padding: EdgeInsets.only(bottom: expandPaddingValue ?? 0),
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
            style: Font.subTitle14.copyWith(color: Colors.white),
          ),
          SizedBox(height: widget.horizontalPadding),
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
