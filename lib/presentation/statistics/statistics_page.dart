import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
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
    final double tabBarHeight =
        getResponsiveRatioByWidth(context, 48) + // TabBar 높이
        getResponsiveRatioByWidth(context, 8) * 2; // Padding Vertical

    return Stack(
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFDF8FF), Color(0xfff4eaff)],
            ),
          ),
        ),
        SafeArea(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // 상단 제목 필요 시 사용
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 16,
                      ),
                      child: Text('모몽의 꿈 통계', style: Font.title20),
                    ),
                  ),

                  // 커스텀 탭바 고정
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      TabBarTitle(horizontalPadding: horizontalPadding),
                      tabBarHeight,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MonthStatistics(horizontalPadding: horizontalPadding),
                  YearStatistics(horizontalPadding: horizontalPadding),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar, this.height);

  final Widget tabBar;
  final double height;

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: const Color(0xffFDF8FF), child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
