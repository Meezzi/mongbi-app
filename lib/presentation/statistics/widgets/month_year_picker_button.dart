import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class MonthYearPickerButton extends ConsumerWidget {
  const MonthYearPickerButton({
    super.key,
    required this.isMonth,
    required this.scrollController,
    required this.horizontalPadding,
  });

  final bool isMonth;
  final ScrollController scrollController;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickerState = ref.watch(pickerViewModelProvider);
    final statisticsAsync = ref.watch(statisticsViewModelProvider);

    return Padding(
      key: isMonth ? monthPickerButton : yearPickerButton,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          if (statisticsAsync.isLoading) return;

          final pickerKey = isMonth ? monthPickerKey : yearPickerKey;
          pickerKey.currentState?.show();
        },
        child: Row(
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                // TODO : 월, 년 나눠서 할당
                isMonth
                    ? DateFormatter.formatMonth(pickerState.focusedMonth)
                    : DateFormatter.formatYear(pickerState.focusedYear),
                style: Font.title16.copyWith(fontSize: 16),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron-down.svg',
              fit: BoxFit.cover,
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}
