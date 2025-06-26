import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
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
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: getResponsiveRatioByWidth(context, 8),
      ),
      child: Container(
        padding: EdgeInsets.all(getResponsiveRatioByWidth(context, 4)),
        decoration: BoxDecoration(
          color: const Color(0xFFF4EAFF),
          borderRadius: BorderRadius.circular(999),
        ),
        height: getResponsiveRatioByWidth(context, 48),
        child: Consumer(
          builder: (context, ref, child) {
            final statisticsVm = ref.read(statisticsViewModelProvider.notifier);

            return TabBar(
              controller: tabController,
              onTap: (value) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                statisticsVm.onChangetabBarIndex(value);
                ref.read(snackBarStatusProvider.notifier).state = false;
                if (value == 0) {
                  statisticsVm.fetchMonthStatistics();
                } else {
                  statisticsVm.fetchYearStatistics();
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
              labelStyle: Font.title14.copyWith(
                fontSize: getResponsiveRatioByWidth(context, 14),
              ),
              unselectedLabelColor: const Color(0xFFB273FF),
              unselectedLabelStyle: Font.title14.copyWith(
                fontSize: getResponsiveRatioByWidth(context, 14),
              ),
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
