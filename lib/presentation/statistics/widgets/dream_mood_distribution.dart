import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/presentation/statistics/widgets/common_box.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution_percent.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution_pie_chart.dart';

class DreamMoodDistribution extends StatelessWidget {
  const DreamMoodDistribution({
    super.key,
    required this.isFirst,
    required this.distribution,
  });

  final bool isFirst;
  final DreamScore? distribution;

  @override
  Widget build(BuildContext context) {
    return CommonBox(
      title: Text('꿈을 꾼 후의 기분 분포도', style: Font.title14),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                if (distribution != null) ...[
                  DreamMoodDistributionPieChart(
                    isFirst: isFirst,
                    distribution: distribution!,
                  ),
                  SizedBox(width: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 21),
                    child: Column(
                      children: [
                        DreamMoodDistributionPercent(
                          isFirst: isFirst,
                          type: 'very_good',
                          percent: distribution!.veryGood,
                        ),
                        SizedBox(height: 8),
                        DreamMoodDistributionPercent(
                          isFirst: isFirst,
                          type: 'good',
                          percent: distribution!.good,
                        ),
                        SizedBox(height: 8),
                        DreamMoodDistributionPercent(
                          isFirst: isFirst,
                          type: 'ordinary',
                          percent: distribution!.ordinary,
                        ),
                        SizedBox(height: 8),
                        DreamMoodDistributionPercent(
                          isFirst: isFirst,
                          type: 'bad',
                          percent: distribution!.bad,
                        ),
                        SizedBox(height: 8),
                        DreamMoodDistributionPercent(
                          isFirst: isFirst,
                          type: 'very_bad',
                          percent: distribution!.veryBad,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
