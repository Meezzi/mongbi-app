import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_bottom_sheet.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class CalendarChangeButton extends ConsumerWidget {
  const CalendarChangeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarViewModelProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Wrap(children: [MonthBottomSheet()]);
                },
              );
            },
            child: Row(
              children: [
                Text(
                  DateFormatter.formatYearMonth(calendarState.focusedDay),
                  style: Font.title16.copyWith(
                    fontSize: getResponsiveRatioByWidth(context, 16),
                  ),
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/chevron-down.svg',
                  fit: BoxFit.cover,
                  width: getResponsiveRatioByWidth(context, 24),
                ),
              ],
            ),
          ),
          if (calendarState.focusedDay.year == DateTime.now().year &&
              calendarState.focusedDay.month == DateTime.now().month)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Color(0xFFF4EAFF),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Color(0xFFDBBEFF)),
              ),
              child: Text(
                '이번달',
                style: Font.subTitle12.copyWith(color: Color(0xFFB273FF)),
              ),
            ),
        ],
      ),
    );
  }
}
