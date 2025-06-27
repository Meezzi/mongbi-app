import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';

class DreamMoodDistributionPieChart extends StatelessWidget {
  const DreamMoodDistributionPieChart({
    super.key,
    required this.isFirst,
    required this.distribution,
  });

  final bool isFirst;
  final DreamScore distribution;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          isFirst
              ? PieChartData(
                sections: [
                  PieChartSectionData(
                    showTitle: false,
                    value: 100,
                    color: Color(0xF5F5F4F5),
                    radius: 40,
                  ),
                ],
              )
              : PieChartData(
                sections: [
                  PieChartSectionData(
                    showTitle: false,
                    value: distribution.veryGood.toDouble(),
                    color: Color(0xFF79E4F9),
                    radius: 40,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    value: distribution.good.toDouble(),
                    color: Color(0xFF45CCBC),
                    radius: 40,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    value: distribution.ordinary.toDouble(),
                    color: Color(0xFF2E5CE6),
                    radius: 40,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    value: distribution.bad.toDouble(),
                    color: Color(0xFF8C2EFF),
                    radius: 40,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    value: distribution.veryBad.toDouble(),
                    color: Color(0xFFEF54A9),
                    radius: 40,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
