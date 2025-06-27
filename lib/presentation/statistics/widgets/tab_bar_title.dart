import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class TabBarTitle extends StatelessWidget {
  const TabBarTitle({
    super.key,

    required this.tabController,
    required this.horizontalPadding,
  });

  final TabController tabController;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF4EAFF),
          borderRadius: BorderRadius.circular(999),
        ),
        height: 48,
        child: Consumer(
          builder: (consumerContext, ref, child) {
            final statisticsAsync = ref.watch(statisticsViewModelProvider);
            final statisticsVm = ref.read(statisticsViewModelProvider.notifier);

            return TabBar(
              controller: tabController,
              onTap: (value) async {
                if (statisticsAsync.isLoading) {
                  // 로딩 중이면 탭 이동 막기
                  tabController.animateTo(statisticsAsync.value!.tabBarIndex);
                  return;
                }

                statisticsVm.onChangetabBarIndex(value);
                ref.read(snackBarStatusProvider.notifier).state = false;
                if (value == 0) {
                  await statisticsVm.fetchMonthStatistics();
                } else {
                  await statisticsVm.fetchYearStatistics();
                }
              },
              tabs: const [Tab(child: Text('월간')), Tab(child: Text('연간'))],
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color(0xFF3B136B),
              labelStyle: Font.title14.copyWith(fontSize: 14),
              unselectedLabelColor: const Color(0xFFB273FF),
              unselectedLabelStyle: Font.title14.copyWith(fontSize: 14),
              splashFactory: NoSplash.splashFactory,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              dividerHeight: 0,
            );
          },
        ),
      ),
    );
  }
}
