import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class CalendarBottomSheetMonthSelector extends ConsumerWidget {
  const CalendarBottomSheetMonthSelector({
    super.key,
    required this.pageController,
    required this.localCalendarState,
    required this.onPageChangeBySwipe,
    required this.onSelectDate,
    required this.maxYear,
    required this.selectedDate,
  });

  final PageController pageController;
  final CalendarModel localCalendarState;
  final void Function(int newPageIndex) onPageChangeBySwipe;
  final void Function({required int year, required int month}) onSelectDate;
  final int maxYear;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarVm = ref.read(calendarViewModelProvider.notifier);
    final now = DateTime.now();

    return Expanded(
      child: PageView.builder(
        controller: pageController,
        reverse: true,
        itemCount: localCalendarState.minYearValue + 1,
        onPageChanged: (index) {
          onPageChangeBySwipe(index);
        },
        itemBuilder: (context, pageIndex) {
          final year = maxYear - pageIndex;
          final isCurrentYear = year == now.year;

          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: getResponsiveRatioByWidth(context, 45),
              mainAxisSpacing: getResponsiveRatioByWidth(context, 8),
              mainAxisExtent: getResponsiveRatioByWidth(context, 48),
            ),
            itemBuilder: (context, index) {
              final month = index + 1;
              final isActive =
                  (selectedDate.year == year) && (selectedDate.month == month);
              final isFutureMonth = isCurrentYear && month > now.month;

              return Center(
                child: GestureDetector(
                  onTap:
                      isFutureMonth
                          ? null
                          : () async {
                            // 바텀시트 내에서 현재 선택된 날짜를 표시하기 위한 메서드
                            onSelectDate(year: year, month: month);
                            await Future.delayed(Duration(milliseconds: 100));

                            // 현재 선택된 날짜를 상태로 저장
                            calendarVm.onChangedCalendar(DateTime(year, month));

                            // 바텀시트 종료
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                  child: Opacity(
                    opacity: isFutureMonth ? 0.3 : 1,
                    child: Container(
                      width: getResponsiveRatioByWidth(context, 48),
                      height: getResponsiveRatioByWidth(context, 48),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isActive ? Color(0xFF8C2EFF) : null,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$month월',
                        style: Font.title16.copyWith(
                          color: isActive ? Colors.white : null,
                          fontSize: getResponsiveRatioByWidth(context, 16),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
