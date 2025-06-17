import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';

class DreamMoodDistributionPieChart extends StatelessWidget {
  const DreamMoodDistributionPieChart({super.key, required this.distribution});

  final DreamScore distribution;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                showTitle: false,
                value: distribution.veryGood.toDouble(),
                color: Color(0xFF79E4F9),
                radius: getResponsiveRatioByWidth(context, 40),
              ),
              PieChartSectionData(
                showTitle: false,
                value: distribution.good.toDouble(),
                color: Color(0xFF45CCBC),
                radius: getResponsiveRatioByWidth(context, 40),
              ),
              PieChartSectionData(
                showTitle: false,
                value: distribution.ordinary.toDouble(),
                color: Color(0xFF2E5CE6),
                radius: getResponsiveRatioByWidth(context, 40),
              ),
              PieChartSectionData(
                showTitle: false,
                value: distribution.bad.toDouble(),
                color: Color(0xFF8C2EFF),
                radius: getResponsiveRatioByWidth(context, 40),
              ),
              PieChartSectionData(
                showTitle: false,
                value: distribution.veryBad.toDouble(),
                color: Color(0xFFEF54A9),
                radius: getResponsiveRatioByWidth(context, 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
