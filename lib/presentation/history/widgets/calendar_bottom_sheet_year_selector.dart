import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class CalendarBottomSheetYearSelector extends StatelessWidget {
  const CalendarBottomSheetYearSelector({
    super.key,
    required this.onPageChangeByIcon,
    required this.selectedYear,
    required this.currentPageIndex,
    required this.maxYear,
    required this.minYear,
  });

  final void Function(int newPageIndex) onPageChangeByIcon;
  final int selectedYear;
  final int currentPageIndex;
  final int maxYear;
  final int minYear;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // 왼쪽(이전 년도로 이동, reverse:true이므로 +1)
            if (currentPageIndex < (maxYear - minYear)) {
              onPageChangeByIcon(currentPageIndex + 1);
            }
          },
          child: Opacity(
            opacity: currentPageIndex == (maxYear - minYear) ? 0.3 : 1,
            child: SvgPicture.asset(
              'assets/icons/chevron-left.svg',
              fit: BoxFit.cover,
              width: getResponsiveRatioByWidth(context, 24),
            ),
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
            // 오른쪽(다음 년도로 이동, reverse:true이므로 -1)
            if (currentPageIndex > 0) {
              onPageChangeByIcon(currentPageIndex - 1);
            }
          },
          child: Opacity(
            opacity: currentPageIndex == 0 ? 0.3 : 1,
            child: SvgPicture.asset(
              'assets/icons/chevron-right.svg',
              fit: BoxFit.cover,
              width: getResponsiveRatioByWidth(context, 24),
            ),
          ),
        ),
      ],
    );
  }
}
