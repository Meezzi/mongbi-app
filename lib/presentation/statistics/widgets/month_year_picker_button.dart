import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker.dart';

class MonthYearPickerButton extends StatelessWidget {
  MonthYearPickerButton({
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
  final monthYearPickerModal = MonthYearPicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: isMonth ? monthPickerButton : yearPickerButton,
      padding: EdgeInsets.symmetric(
        vertical: getResponsiveRatioByWidth(context, 8),
      ),
      child: GestureDetector(
        onTap: () {
          monthYearPickerModal.show(
            context,
            isMonth: isMonth,
            left: horizontalPadding,
            top: pickerButtonPosition,
            scrollController: scrollController,
          );
        },
        child: Row(
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                // TODO : 월, 년 나눠서 할당
                isMonth
                    ? DateFormatter.formatMonth(
                      DateTime(DateTime.now().year, DateTime.now().month),
                    )
                    : DateFormatter.formatYear(
                      DateTime(DateTime.now().year, DateTime.now().month),
                    ),
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
