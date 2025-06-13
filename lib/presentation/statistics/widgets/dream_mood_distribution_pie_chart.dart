import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DreamMoodDistributionPieChart extends StatelessWidget {
  const DreamMoodDistributionPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            // sectionsSpace: 0,
            sections: [
              PieChartSectionData(
                showTitle: false,
                value: 10,
                color: Color(0xFF79E4F9),
                radius: 40,
              ),
              PieChartSectionData(
                showTitle: false,
                value: 20,
                color: Color(0xFF45CCBC),
                radius: 40,
              ),
              PieChartSectionData(
                showTitle: false,
                value: 15,
                color: Color(0xFF2E5CE6),
                radius: 40,
              ),
              PieChartSectionData(
                showTitle: false,
                value: 40,
                color: Color(0xFFEF54A9),
                radius: 40,
              ),
              PieChartSectionData(
                showTitle: false,
                value: 15,
                color: Color(0xFF8C2EFF),
                radius: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
