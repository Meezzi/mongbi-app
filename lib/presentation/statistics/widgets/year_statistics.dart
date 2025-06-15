import 'package:flutter/material.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_frequency_card.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_type_mood_state.dart';
import 'package:mongbi_app/presentation/statistics/widgets/gift_frequency_card.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker_button.dart';
import 'package:mongbi_app/presentation/statistics/widgets/psychology_keyword_chart.dart';

class YearStatistics extends StatefulWidget {
  const YearStatistics({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  State<YearStatistics> createState() => _YearStatisticsState();
}

class _YearStatisticsState extends State<YearStatistics> {
  bool isMonth = false;
  double? yearPickerButtonPosition;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final yearPickerButtonInfo = getWidgetInfo(yearPickerButton);
      final yearButtonPosition =
          yearPickerButtonInfo!.localToGlobal(Offset.zero).dy;
      final yearButtonHeight = yearPickerButtonInfo.size.height;
      setState(() {
        yearPickerButtonPosition = yearButtonPosition + yearButtonHeight;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO : 현재 달, 또는 선택한 달
    final now = DateTime(2025, 6);
    final afterOneMonth = DateTime(now.year, now.month + 1);
    final totlaDays =
        DateTime(
          afterOneMonth.year,
          afterOneMonth.month,
          afterOneMonth.day - 1,
        ).day;

    return ListView(
      padding: EdgeInsets.only(
        left: widget.horizontalPadding,
        right: widget.horizontalPadding,
        bottom: 95,
      ),
      children: [
        Stack(
          children: [
            Column(
              children: [
                MonthYearPickerButton(
                  isMonth: isMonth,
                  scrollController: scrollController,
                  pickerButtonPosition: yearPickerButtonPosition ?? 0,
                  horizontalPadding: widget.horizontalPadding,
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: getResponsiveRatioByWidth(context, 16),
                  ),
                  child: Row(
                    children: [
                      DreamFrequencyCard(frequency: 15, totalDays: totlaDays),
                      SizedBox(width: getResponsiveRatioByWidth(context, 16)),
                      GiftFrequencyCard(frequency: 95),
                    ],
                  ),
                ),
                DreamMoodDistribution(),
                DreamTypeMoodState(isMonth: isMonth),
                PsychologyKeywordChart(
                  // TODO : 데이터 변수 들어가야 함
                  keywordList: ['1순위', '2순위', '3순위', '4순위', '5순위'] ?? [],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
