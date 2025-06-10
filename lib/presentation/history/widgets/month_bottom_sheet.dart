import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print('왼');
                  // 왼쪽(이전 년도로 이동, reverse:true이므로 +1)
                  if (currentPageIndex < (maxYear - minYear)) {
                    goToPage(currentPageIndex + 1);
                  }
                },
                child: SvgPicture.asset(
                  'assets/icons/chevron-left.svg',
                  fit: BoxFit.cover,
                  width: getResponsiveRatioByWidth(context, 24),
                ),
              ),
              Text(
                '$selectedYear년',
                style: Font.title16.copyWith(
                  fontSize: getResponsiveRatioByWidth(context, 16),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('오');
                  // 오른쪽(다음 년도로 이동, reverse:true이므로 -1)
                  if (currentPageIndex > 0) {
                    goToPage(currentPageIndex - 1);
                  }
                },
                child: SvgPicture.asset(
                  'assets/icons/chevron-right.svg',
                  fit: BoxFit.cover,
                  width: getResponsiveRatioByWidth(context, 24),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              reverse: true,
              itemCount: localCalendarState.minYearValue + 1,
              onPageChanged: (index) {
                print('✅');
                print('페이지 이동? index: $index');
                print('✅');
                setState(() {
                  currentPageIndex = index;

                  // 년만 이동, 월은 선택된 값 유지
                  selectedYear = maxYear - index;
                });
              },
              itemBuilder: (context, pageIndex) {
                final year = maxYear - pageIndex;

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
                        (selectedDate.year == year) &&
                        (selectedDate.month == month);

                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // 선택한 년과 월로 재설정
                            selectedDate = DateTime(year, month);
                          });
                          ref
                              .read(calendarViewModelProvider.notifier)
                              .onChangedCalendar(DateTime(year, month));
                          Navigator.pop(context);
                        },
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 뷰모델을 계속 사용하지 않기 위해 메서드 생성
  /// 바텀시트의 년과 월을 이동하는 메서드
  void goToPage(int newPageIndex) {
    pageController.animateToPage(
      newPageIndex,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    setState(() {
      currentPageIndex = newPageIndex;

      // 년만 이동, 월은 선택된 값 유지
      selectedYear = maxYear - newPageIndex;
    });
  }
}
