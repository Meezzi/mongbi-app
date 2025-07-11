import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/statistics/widgets/custom_snack_bar.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_statistics.dart';
import 'package:mongbi_app/presentation/statistics/widgets/tab_bar_title.dart';
import 'package:mongbi_app/presentation/statistics/widgets/year_statistics.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage>
    with TickerProviderStateMixin {
  final double horizontalPadding = 24;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: ref.read(tabBarIndexProvider),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double tabBarHeight =
        48 + // TabBar 높이
        8 * 2; // Padding Vertical
    final splashState = ref.watch(splashViewModelProvider);
    final nickname = splashState.userList?[0].userNickname ?? '몽비';
    final snackBarState = ref.watch(snackBarStatusProvider);
    final statisticsAsync = ref.watch(statisticsViewModelProvider);

    return SafeArea(
      left: false,
      right: false,
      child: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // 상단 제목 필요 시 사용
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        top: 15,
                        bottom: 16,
                      ),
                      child: Text('$nickname의 꿈 통계', style: Font.title20),
                    ),
                  ),
                ),

                // 커스텀 탭바 고정
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverTabBarDelegate(
                    TabBarTitle(
                      tabController: tabController,
                      horizontalPadding: horizontalPadding,
                    ),
                    tabBarHeight,
                  ),
                ),
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFF4EAFF)],
                ),
              ),
              child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MonthStatistics(horizontalPadding: horizontalPadding),
                  YearStatistics(horizontalPadding: horizontalPadding),
                ],
              ),
            ),
          ),
          if (statisticsAsync.isLoading)
            Center(child: CircularProgressIndicator()),
          if (snackBarState)
            Positioned(bottom: 18, left: 0, right: 0, child: CustomSnackBar()),
        ],
      ),
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
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}