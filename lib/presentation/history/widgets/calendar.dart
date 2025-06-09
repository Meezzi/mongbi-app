import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/view_models/calendar_view_model.dart';
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
      headerVisible: false, // 기본 헤더 숨김!
      pageAnimationEnabled: false,
      availableGestures: AvailableGestures.none,
      focusedDay: calendarState.focusedDay,
      firstDay: DateTime.utc(DateTime.now().year, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year, 12, 31),
      selectedDayPredicate: (day) {
        return calendarState.selectedDay != null &&
            day == calendarState.selectedDay;
      },
      onDaySelected: (selectedDay, focusedDay) {
        print('❤️날짜 선택 - selectedDay : $selectedDay');
        print('❤️날짜 선택 - focusedDay : $focusedDay');
        calendarVm.onDaySelected(selectedDay, focusedDay);
      },
      onPageChanged: (focusedDay) {
        print('❤️페이지 이동');
        print(focusedDay);
        calendarVm.onPageChanged(focusedDay);
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        cellMargin: EdgeInsets.zero,
        isTodayHighlighted: false,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: circleWidth,
                  height: circleWidth,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    shape: BoxShape.circle,
                  ),
                  child:
                      day.day <= 5
                          ? SvgPicture.asset(
                            'assets/icons/good.svg',
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
                SizedBox(height: 4),
                Text(
                  '${day.day}',
                  style: Font.subTitle14.copyWith(
                    fontSize: fontViewWidth,
                    color: Color(0xFFB273FF),
                  ),
                ),
              ],
            ),
          );
        },
        // 선택된 날짜의 스타일 커스텀
        // ✅✅ TableCalendar.selectedDayPredicate 속성이 있어야만 동작
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: circleWidth,
                  height: circleWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${day.day}',
                  style: Font.subTitle14.copyWith(fontSize: fontViewWidth),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
