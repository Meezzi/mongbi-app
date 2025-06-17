import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/presentation/statistics/widgets/common_box.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution_percent.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution_pie_chart.dart';

class DreamMoodDistribution extends StatelessWidget {
  const DreamMoodDistribution({super.key, required this.distribution});

  final DreamScore? distribution;

  @override
  Widget build(BuildContext context) {
    return CommonBox(
      title: Text(
        '꿈을 꾼 후의 기분 분포도',
        style: Font.title14.copyWith(
          fontSize: getResponsiveRatioByWidth(context, 14),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getResponsiveRatioByWidth(context, 24),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                if (distribution != null) ...[
                  DreamMoodDistributionPieChart(distribution: distribution!),
                  SizedBox(width: getResponsiveRatioByWidth(context, 40)),
                  Padding(
                    padding: const EdgeInsets.only(right: 21),
                    child: Column(
                      children: [
                        DreamMoodDistributionPercent(
                          type: 'very_good',
                          percent: distribution!.veryGood,
                        ),
                        SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                        DreamMoodDistributionPercent(
                          type: 'good',
                          percent: distribution!.good,
                        ),
                        SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                        DreamMoodDistributionPercent(
                          type: 'ordinary',
                          percent: distribution!.ordinary,
                        ),
                        SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                        DreamMoodDistributionPercent(
                          type: 'bad',
                          percent: distribution!.bad,
                        ),
                        SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                        DreamMoodDistributionPercent(
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
