import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';

class MonthYearPickerButton extends StatelessWidget {
  const MonthYearPickerButton({super.key, required this.showMonthPickerModal});

  final VoidCallback showMonthPickerModal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: monthPickerButton,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          showMonthPickerModal();
        },
        child: Row(
          children: [
            Text(
              DateFormatter.formatMonth(
                DateTime(DateTime.now().year, DateTime.now().month),
              ),
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
    );
  }
}
