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
  String? prevDisplayedYear; // 이전에 표시된 년

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    scrollController.dispose();
    routeObserver.unsubscribe(this);
    yearSnackBarKey.currentState?.hide(); // 페이지 사라질 때 스낵바 강제 종료
    super.dispose();
  }

  @override
  void didPushNext() {
    // 다른 페이지로 이동 시
    yearSnackBarKey.currentState?.hide();
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

                    // TODO : 통계 스낵바 사용하지 않으니 일단 주석
                    // 년이 바뀌었거나, 같은 년을 다시 선택했을 때 항상 스낵바를 hide
                    // final currentYear = yearStatistics?.year; // "2025"

                    // if (prevDisplayedYear != null &&
                    //     prevDisplayedYear != currentYear) {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     yearSnackBarKey.currentState?.hide();
                    //   });
                    // }

                    // 이전 년(현재가 아닌 년) 선택 시 무조건 스낵바 제거
                    // if (!isCurrent) {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     yearSnackBarKey.currentState?.hide();
                    //   });
                    // }

                    // 현재 년 + isFirst + 라우트 확인 => 스낵바 표시
                    // if (isCurrent && isFirst) {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     if (ModalRoute.of(context)?.isCurrent == true &&
                    //         mounted) {
                    //       yearSnackBarKey.currentState?.hide(); // 항상 hide 후
                    //       yearSnackBarKey.currentState?.show(); // 다시 show
                    //     }
                    //   });
                    // }

                    // 현재 표시 년 갱신
                    // prevDisplayedYear = currentYear;

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
                    return Center(child: Text('예기치 못한 오류가 발생했습니다.'));
                  },
                ),
              ],
            ),
            CustomSnackBar(key: yearSnackBarKey),
          ],
        ),
      ],
    );
  }
}
