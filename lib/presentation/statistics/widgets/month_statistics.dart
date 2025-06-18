import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/core/route_observer.dart';
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
  bool snackBarShown = false;
  String? currentDisplayedMonth;

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
  void didPopNext() {
    // 다른 페이지에서 돌아올 때
    snackBarShown = false; // 플래그 초기화
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
                    final yearMonth = monthStatistics?.month?.split(
                      '-',
                    ); // "2025-06"
                    final frequency = monthStatistics?.frequency;
                    final totalDays = monthStatistics?.totalDays;
                    final distribution = monthStatistics?.distribution;
                    final moodState = monthStatistics?.moodState;
                    final keywordList = monthStatistics?.keywords;
                    final isFirst = frequency == 0;
                    final now = DateTime.now();
                    final isCurrent =
                        now.year == int.parse(yearMonth![0]) &&
                        now.month == int.parse(yearMonth[1]);

                    // 내가 지금 보고 있는 월(내가 선택한 월) 감지
                    final currentMonth = monthStatistics?.month; // "2025-06"
                    if (currentDisplayedMonth != null &&
                        currentDisplayedMonth != currentMonth) {
                      snackBarShown = false;
                      monthSnackBarKey.currentState?.hide();
                    }
                    currentDisplayedMonth = currentMonth;

                    // 이전 월(현재가 아닌 월) 선택 시 무조건 스낵바 제거
                    if (!isCurrent) {
                      monthSnackBarKey.currentState?.hide();
                      snackBarShown = false;
                    }

                    // 현재 월 + isFirst + 라우트 확인 => 스낵바 표시
                    if (isCurrent && isFirst && !snackBarShown) {
                      if (ModalRoute.of(context)?.isCurrent == true) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            monthSnackBarKey.currentState?.show();
                            snackBarShown = true;
                          }
                        });
                      }
                    }

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
            CustomSnackBar(key: monthSnackBarKey),
          ],
        ),
      ],
    );
  }
}
