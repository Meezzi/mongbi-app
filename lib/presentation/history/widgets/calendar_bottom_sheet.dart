import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_bottom_sheet_month_selector.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_bottom_sheet_year_selector.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class MonthBottomSheet extends ConsumerStatefulWidget {
  const MonthBottomSheet({super.key});

  @override
  ConsumerState<MonthBottomSheet> createState() => _MonthBottomSheetState();
}

class _MonthBottomSheetState extends ConsumerState<MonthBottomSheet> {
  late CalendarModel localCalendarState;
  late int minYear;
  late int maxYear;
  late int initialYear;
  late int initialMonth;

  late int selectedYear;
  late int selectedMonth;
  late DateTime selectedDate;
  late int currentPageIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    // 바텀시트가 보일 때만 상태 값을 반영하기 위해 initState에서 ref.read 사용
    localCalendarState = ref.read(calendarViewModelProvider);
    minYear = localCalendarState.minDateTime.year;
    maxYear = localCalendarState.maxDateTime.year;

    // 바텀시트가 보일 때 사용자가 선택한 년과 월을 표시하기 위한 변수
    initialYear = localCalendarState.focusedDay.year;
    initialMonth = localCalendarState.focusedDay.month;
    currentPageIndex = maxYear - initialYear;

    // 해당 년과 월에 일치하는 곳에 액티브 하기 위한 변수
    selectedYear = initialYear;
    selectedMonth = initialMonth;
    selectedDate = DateTime(initialYear, initialMonth);

    // PageView는 maxYear가 0번째, minYear가 마지막 인덱스가 되도록 reverse:true로 동작
    // 즉, 사용자의 현재 년도가 0번째 인덱스가 되며, 왼쪽으로 스와이프 될 때 1씩 증가
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getResponsiveRatioByWidth(context, 282),
      padding: EdgeInsets.only(top: 24, bottom: 24 + 34, left: 24, right: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          CalendarBottomSheetYearSelector(
            onPageChangeByIcon: onPageChangeByIcon,
            selectedYear: selectedYear,
            currentPageIndex: currentPageIndex,
            maxYear: maxYear,
            minYear: minYear,
          ),
          SizedBox(height: 16),
          CalendarBottomSheetMonthSelector(
            pageController: pageController,
            localCalendarState: localCalendarState,
            onPageChangeBySwipe: onPageChangeBySwipe,
            onSelectDate: onSelectDate,
            maxYear: maxYear,
            selectedDate: selectedDate,
          ),
        ],
      ),
    );
  }

  // 뷰모델을 계속 사용하지 않기 위해 메서드 생성
  /// 좌우 아이콘으로 바텀시트의 년과 월을 이동하는 메서드
  void onPageChangeByIcon(int newPageIndex) {
    pageController.animateToPage(
      newPageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
    setState(() {
      currentPageIndex = newPageIndex;

      // 년만 이동, 월은 선택된 값 유지
      selectedYear = maxYear - newPageIndex;
    });
  }

  /// 스와이프로 바텀시트의 년과 월을 이동하는 메서드
  void onPageChangeBySwipe(int newPageIndex) {
    setState(() {
      currentPageIndex = newPageIndex;

      // 년만 이동, 월은 선택된 값 유지
      selectedYear = maxYear - newPageIndex;
    });
  }

  /// 바텀시트 내에서 현재 선택된 날짜를 표시하기 위한 메서드
  void onSelectDate({required int year, required int month}) {
    setState(() {
      // 선택한 년과 월로 재설정
      selectedDate = DateTime(year, month);
    });
  }
}
