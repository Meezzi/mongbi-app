import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_cell.dart';
import 'package:mongbi_app/providers/history_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends ConsumerWidget {
  const Calendar({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarViewModelProvider);
    final calendarVm = ref.read(calendarViewModelProvider.notifier);
    final deviceSize = MediaQuery.of(context).size;
    final double calendarWidth = deviceSize.width - horizontalPadding * 2;
    final double cellWidth = calendarWidth / 7; // 375기준 46.7
    final double cellHeight = cellWidth * 1.63; // 375기준 76
    final double circleWidth = cellWidth * 0.86; // 375기준 40
    final double daysOfWeekHeight = cellHeight * 0.56;
    final double fontViewWidth = deviceSize.width * 0.038;

    return TableCalendar(
      locale: 'ko_KR',
      rowHeight: cellHeight,
      daysOfWeekHeight: daysOfWeekHeight,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: Font.subTitle14,
        weekendStyle: Font.subTitle14,
      ),
      headerVisible: false,
      pageAnimationEnabled: false,
      availableGestures: AvailableGestures.none,
      focusedDay: calendarState.focusedDay,
      firstDay: calendarState.minDateTime,
      lastDay: calendarState.maxDateTime,
      selectedDayPredicate: (day) {
        return calendarState.selectedDay != null &&
            day == calendarState.selectedDay;
      },
      onDaySelected: (selectedDay, focusedDay) {
        calendarVm.onDaySelected(selectedDay, focusedDay);
      },
      onPageChanged: (focusedDay) {
        calendarVm.onPageChanged(focusedDay);
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        cellMargin: EdgeInsets.zero,
        isTodayHighlighted: false,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return CalendarCell(
            day: day,
            type: 'default',
            circleWidth: circleWidth,
            fontViewWidth: fontViewWidth,
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return CalendarCell(
            day: day,
            type: 'seleted',
            circleWidth: circleWidth,
            fontViewWidth: fontViewWidth,
          );
        },
      ),
    );
  }
}
