import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/core/route_observer.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/presentation/statistics/statistics_key/statistics_key.dart';
import 'package:mongbi_app/presentation/statistics/widgets/custom_snack_bar.dart';
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

class _MonthStatisticsState extends ConsumerState<MonthStatistics>
    with RouteAware {
  bool isMonth = true;
  double? monthPickerButtonPosition;
  final ScrollController scrollController = ScrollController();
  String? prevDisplayedMonth; // 이전에 표시된 월

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    scrollController.dispose();
    routeObserver.unsubscribe(this);
    monthSnackBarKey.currentState?.hide(); // 페이지 사라질 때 스낵바 강제 종료
    super.dispose();
  }

  @override
  void didPushNext() {
    // 다른 페이지로 이동 시
    monthSnackBarKey.currentState?.hide();
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
                    final now = DateTime.now();
                    final yearMonth =
                        monthStatistics?.month?.split('-') ??
                        [
                          pickerState.focusedMonth.year.toString(),
                          pickerState.focusedMonth.month.toString(),
                        ]; // "2025-06"
                    final frequency = monthStatistics?.frequency ?? 0;
                    final totalDays = monthStatistics?.totalDays ?? 0;
                    final distribution =
                        monthStatistics?.distribution ?? DreamScore();
                    final moodState = monthStatistics?.moodState;
                    final keywordList = monthStatistics?.keywords;
                    final isFirst = frequency == 0;
                    final isCurrent =
                        now.year == int.parse(yearMonth[0]) &&
                        now.month == int.parse(yearMonth[1]);

                    // 월이 바뀌었거나, 같은 월을 다시 선택했을 때 항상 스낵바를 hide
                    final currentMonth = monthStatistics?.month; // "2025-06"

                    if (prevDisplayedMonth != null &&
                        prevDisplayedMonth != currentMonth) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        monthSnackBarKey.currentState?.hide();
                      });
                    }

                    // 이전 월(현재가 아닌 월) 선택 시 무조건 스낵바 제거
                    if (!isCurrent) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        monthSnackBarKey.currentState?.hide();
                      });
                    }

                    // 현재 월 + isFirst + 라우트 확인 => 스낵바 표시
                    if (isCurrent && isFirst) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (ModalRoute.of(context)?.isCurrent == true &&
                            mounted) {
                          monthSnackBarKey.currentState?.hide(); // 항상 hide 후
                          monthSnackBarKey.currentState?.show(); // 다시 show
                        }
                      });
                    }

                    // 현재 표시 월 갱신
                    prevDisplayedMonth = currentMonth;

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
            CustomSnackBar(key: monthSnackBarKey),
          ],
        ),
      ],
    );
  }
}
