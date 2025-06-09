import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/view_models/calendar_view_model.dart';

class CalendarDropDownButton extends ConsumerWidget {
  const CalendarDropDownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarViewModelProvider);
    final calendarVm = ref.read(calendarViewModelProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            value: calendarState.dropDownvalue,
            style: Font.title16,
            isDense: true,
            underline: SizedBox(),
            icon: SvgPicture.asset('assets/icons/chevron-down.svg'),
            items: List.generate(12, (index) {
              final now = DateTime.now();
              final year = now.year;
              final month = index + 1;
              final day = 1;
              final date = DateTime(year, month, day);

              return DropdownMenuItem(
                value: DateFormatter.formatYearMonth(date),
                onTap: () {
                  calendarVm.onChangedCalendar(date);
                },
                child: Text(DateFormatter.formatYearMonth(date)),
              );
            }),
            onChanged: (value) {
              calendarVm.onChangeDropDownValue(value);
            },
          ),
          if (calendarState.focusedDay.month == DateTime.now().month)
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
