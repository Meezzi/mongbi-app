import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final ScrollController scrollController = ScrollController();

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
              horizontalPadding: widget.horizontalPadding,
            ),

            MonthYearPicker(
              key: isMonth ? monthPickerKey : yearPickerKey,
              isMonth: isMonth,
              scrollController: scrollController,
            ),

            statisticsAsync.when(
              loading: () {
                return SizedBox();
              },
              data: (data) {
                final yearStatistics = data?.year;
                final now = DateTime.now();
                final year =
                    yearStatistics?.year ??
                    pickerState.focusedYear.year.toString(); // "2025"
                final frequency = yearStatistics?.frequency ?? 0;
                final challengeSuccessRate =
                    yearStatistics?.challengeSuccessRate ?? 0;
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
                  } else {
                    ref.read(snackBarStatusProvider.notifier).state = false;
                  }
                });

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          DreamFrequencyCard(
                            isFirst: isFirst,
                            frequency: frequency,
                            totalDays: totalDays,
                          ),
                          SizedBox(width: 16),
                          GiftFrequencyCard(
                            isFirst: isFirst,
                            challengeSuccessRate: challengeSuccessRate,
                          ),
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
