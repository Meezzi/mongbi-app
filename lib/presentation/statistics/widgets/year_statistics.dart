import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_frequency_card.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_type_mood_state.dart';
import 'package:mongbi_app/presentation/statistics/widgets/gift_frequency_card.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker_button.dart';
import 'package:mongbi_app/presentation/statistics/widgets/psychology_keyword_chart.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class YearStatistics extends ConsumerStatefulWidget {
  const YearStatistics({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  ConsumerState<YearStatistics> createState() => _YearStatisticsState();
}

class _YearStatisticsState extends ConsumerState<YearStatistics>
    with RouteAware {
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
    final statisticsAsync = ref.watch(statisticsViewModelProvider);
    final pickerState = ref.watch(pickerViewModelProvider);

    return ListView(
      padding: EdgeInsets.only(
        left: widget.horizontalPadding,
        right: widget.horizontalPadding,
        bottom: 95,
      ),
      children: [
        Column(
          children: [
            MonthYearPickerButton(
              isMonth: isMonth,
              scrollController: scrollController,
              pickerButtonPosition: yearPickerButtonPosition ?? 0,
              horizontalPadding: widget.horizontalPadding,
            ),

            MonthYearPicker(
              key: isMonth ? monthPickerKey : yearPickerKey,
              isMonth: isMonth,
              scrollController: scrollController,
              top: yearPickerButtonPosition ?? 0,
              left: widget.horizontalPadding,
            ),

            statisticsAsync.when(
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              data: (data) {
                final yearStatistics = data?.year;
                final now = DateTime.now();
                final year =
                    yearStatistics?.year ??
                    pickerState.focusedYear.year.toString(); // "2025"
                final frequency = yearStatistics?.frequency ?? 0;
                final totalDays = yearStatistics?.totalDays ?? 0;
                final distribution =
                    yearStatistics?.distribution ?? DreamScore();
                final moodState = yearStatistics?.moodState;
                final keywordList = yearStatistics?.keywords;
                final isFirst = frequency == 0;
                final isCurrent = now.year == int.parse(year);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (isFirst && isCurrent) {
                    ref.read(snackBarStatusProvider.notifier).state = true;
                  }
                });

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: getResponsiveRatioByWidth(context, 16),
                      ),
                      child: Row(
                        children: [
                          DreamFrequencyCard(
                            isFirst: isFirst,
                            frequency: frequency,
                            totalDays: totalDays,
                          ),
                          SizedBox(
                            width: getResponsiveRatioByWidth(context, 16),
                          ),
                          GiftFrequencyCard(isFirst: isFirst, frequency: 0),
                        ],
                      ),
                    ),
                    DreamMoodDistribution(
                      isFirst: isFirst,
                      distribution: distribution,
                    ),
                    DreamTypeMoodState(isMonth: isMonth, moodState: moodState),
                    PsychologyKeywordChart(
                      isFirst: isFirst,
                      keywordList: keywordList ?? [],
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text('예기치 못한 오류가 발생했습니다.'));
              },
            ),
          ],
        ),
      ],
    );
  }
}
