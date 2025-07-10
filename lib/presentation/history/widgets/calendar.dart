import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_cell.dart';
import 'package:mongbi_app/providers/history_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends ConsumerWidget {
  const Calendar({
    super.key,
    required this.horizontalPadding,
    required this.scrollController,
  });

  final double horizontalPadding;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarViewModelProvider);
    final calendarVm = ref.read(calendarViewModelProvider.notifier);
    final double cellWidth = 46.7; // 375기준 46.7
    final double cellHeight = 76; // 375기준 76
    final double circleWidth = 40; // 375기준 40
    final double daysOfWeekHeight = 40; // 375기준 40

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
        onScrollToTop(
          data: calendarState.searchedHistory,
          selectedDay: selectedDay,
          scrollController: scrollController,
        );
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
            isSelected: false,
            cellWidth: cellWidth,
            circleWidth: circleWidth,
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return CalendarCell(
            day: day,
            isSelected: true,
            cellWidth: cellWidth,
            circleWidth: circleWidth,
          );
        },
      ),
    );
  }

  void onScrollToTop({
    required List<History> data,
    required DateTime selectedDay,
    required ScrollController scrollController,
  }) {
    final hasRecord = data.any(
      (record) =>
          record.dreamRegDate.year == selectedDay.year &&
          record.dreamRegDate.month == selectedDay.month &&
          record.dreamRegDate.day == selectedDay.day,
    );
    if (!hasRecord) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (scrollController.hasClients) {
          await Future.delayed(Duration(milliseconds: 1));
          await scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        }
      });
    }
  }
}
