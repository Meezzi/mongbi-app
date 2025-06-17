import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_frequency_card.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_type_mood_state.dart';
import 'package:mongbi_app/presentation/statistics/widgets/gift_frequency_card.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker_button.dart';
import 'package:mongbi_app/presentation/statistics/widgets/psychology_keyword_chart.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class MonthStatistics extends ConsumerStatefulWidget {
  const MonthStatistics({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  ConsumerState<MonthStatistics> createState() => _MonthStatisticsState();
}

class _MonthStatisticsState extends ConsumerState<MonthStatistics> {
  bool isMonth = true;
  double? monthPickerButtonPosition;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final monthPickerButtonInfo = getWidgetInfo(monthPickerButton);
      final monthButtonPosition =
          monthPickerButtonInfo!.localToGlobal(Offset.zero).dy;
      final monthButtonHeight = monthPickerButtonInfo.size.height;
      setState(() {
        monthPickerButtonPosition = monthButtonPosition + monthButtonHeight;
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
                  pickerButtonPosition: monthPickerButtonPosition ?? 0,
                  horizontalPadding: widget.horizontalPadding,
                ),

                MonthYearPicker(
                  key: isMonth ? monthPickerKey : yearPickerKey,
                  isMonth: isMonth,
                  scrollController: scrollController,
                  left: widget.horizontalPadding,
                  top: monthPickerButtonPosition ?? 0,
                ),

                statisticsAsync.when(
                  loading: () {
                    return Center(child: CircularProgressIndicator());
                  },
                  data: (data) {
                    final monthStatistics = data?.month;
                    final frequency = monthStatistics?.frequency;
                    final totalDays = monthStatistics?.totalDays;
                    final distribution = monthStatistics?.distribution;
                    final moodState = monthStatistics?.moodState;
                    final keywordList = monthStatistics?.keywords;
                    final isFirst = frequency == 0;

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
                                frequency: frequency ?? 0,
                                totalDays: totalDays ?? 0,
                              ),
                              SizedBox(
                                width: getResponsiveRatioByWidth(context, 16),
                              ),
                              // TODO : 챌린지 달성률 아직 데이터 없음
                              GiftFrequencyCard(isFirst: isFirst, frequency: 0),
                            ],
                          ),
                        ),
                        DreamMoodDistribution(
                          isFirst: isFirst,
                          distribution: distribution,
                        ),
                        DreamTypeMoodState(
                          isMonth: isMonth,
                          moodState: moodState,
                        ),
                        PsychologyKeywordChart(
                          isFirst: isFirst,
                          keywordList: keywordList ?? [],
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(child: Text('예기치 못한 오류가 발생했다몽'));
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
