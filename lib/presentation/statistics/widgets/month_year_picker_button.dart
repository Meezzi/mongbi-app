import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class MonthYearPickerButton extends ConsumerWidget {
  const MonthYearPickerButton({
    super.key,
    required this.isMonth,
    required this.scrollController,
    required this.pickerButtonPosition,
    required this.horizontalPadding,
  });

  final bool isMonth;
  final ScrollController scrollController;
  final double pickerButtonPosition;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickerState = ref.watch(pickerViewModelProvider);
    print('여기는?');

    return Padding(
      key: isMonth ? monthPickerButton : yearPickerButton,
      padding: EdgeInsets.symmetric(
        vertical: getResponsiveRatioByWidth(context, 8),
      ),
      child: GestureDetector(
        onTap: () {
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
                style: Font.title16.copyWith(
                  fontSize: getResponsiveRatioByWidth(context, 16),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron-down.svg',
              fit: BoxFit.cover,
              width: getResponsiveRatioByWidth(context, 24),
            ),
          ],
        ),
      ),
    );
  }
}
