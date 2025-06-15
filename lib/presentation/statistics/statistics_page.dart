import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_statistics.dart';
import 'package:mongbi_app/presentation/statistics/widgets/tab_bar_title.dart';
import 'package:mongbi_app/presentation/statistics/widgets/year_statistics.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final double horizontalPadding = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFDF8FF), Color(0xffEAC9FA)],
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBarTitle(horizontalPadding: horizontalPadding),
            // 탭바뷰가 화면을 꽉 채우게 Expanded로 랩핑
            Expanded(
              child: TabBarView(
                children: [
                  // 월 통계
                  MonthStatistics(horizontalPadding: horizontalPadding),

                  // 연 통계
                  YearStatistics(horizontalPadding: horizontalPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
