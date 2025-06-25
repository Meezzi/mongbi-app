import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MainNaviTabBar extends StatelessWidget {
  const MainNaviTabBar({
    super.key,
    required this.path,
    required this.selected,
    required this.iconName,
    required this.isHistory,
    required this.isStatistics,
    required this.location,
  });

  final String path;
  final bool selected;
  final String iconName;
  final bool isHistory;
  final bool isStatistics;
  final String location;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final colorSuffix = isHistory ? '_purple' : '';
    final stateSuffix = selected ? 'filled' : 'outlined';

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        context.go(path);
      },
      child: SvgPicture.asset(
        'assets/icons/$iconName${colorSuffix}_$stateSuffix.svg',
        width: 24,
        height: 24,
      ),
    );
  }
}
