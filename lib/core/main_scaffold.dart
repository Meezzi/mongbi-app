import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/providers/alarm_provider.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String location = GoRouterState.of(context).uri.toString();
    int selectedIndex = switch (location) {
      _ when location.startsWith('/history') => 1,
      _ when location.startsWith('/statistics') => 2,
      _ when location.startsWith('/setting') => 3,
      _ => 0,
    };

    final isHistory = location.startsWith('/history');

    return Scaffold(
      backgroundColor: _buildScaffoldBackgroundColor(location),
      appBar: _buildAppBar(context, location),
      extendBodyBehindAppBar: location.startsWith('/home') ? true : false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 480) {
            return Center(child: SizedBox(width: 480, child: child));
          }
          return child;
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: _buildBottomAppBarColor(location),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTab(
              context,
              0,
              selectedIndex == 0,
              'home',
              '/home',
              isHistory,
            ),
            _buildTab(
              context,
              1,
              selectedIndex == 1,
              'record',
              '/history',
              isHistory,
            ),
            GestureDetector(
              onTap: () async {
                final uid = await SecureStorageService().getUserIdx();

                if (uid == null) return;

                final canWrite = await ref
                    .read(canWriteDreamTodayUseCaseProvider)
                    .execute(uid);

                if (canWrite) {
                  await context.push('/dream_intro');
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(customSnackBar('오늘은 이미 했어, 배불러몽!', 16, 2));
                }
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1A181B).withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: Offset(2, 2),
                      spreadRadius: 0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: isHistory ? [0.1, 1.0] : [0, 1.0],
                    colors:
                        isHistory
                            ? [Color(0xFFEAC9FA), Color(0xFF8C2EFF)]
                            : [Color(0xFF8C2EFF), Color(0xFF3B136B)],
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.none,
                ),
              ),
            ),
            _buildTab(
              context,
              2,
              selectedIndex == 2,
              'statistics',
              '/statistics',
              isHistory,
            ),
            _buildTab(
              context,
              3,
              selectedIndex == 3,
              'user',
              '/setting',
              isHistory,
            ),
          ],
        ),
      ),
    );
  }

  Color _buildScaffoldBackgroundColor(String location) {
    if (location.startsWith('/statistics')) {
      return Color(0xFFFFFFFF);
    }
    return Color(0xFFFAFAFA);
  }

  Color _buildBottomAppBarColor(String location) {
    switch (location) {
      case '/home':
      case '/statistics':
        return Colors.white;
      case '/history':
        return Color(0xFF3B136B);
      case '/setting':
        return Color(0xFFFCF6FF);
      default:
        return Colors.white;
    }
  }

  AppBar? _buildAppBar(BuildContext context, String location) {
    if (location.startsWith('/home')) {
      return AppBar(
        title: Center(
          child: SizedBox(
            width:
                MediaQuery.sizeOf(context).width >= 480 ? 480 : double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    'MONGBI',
                    style: Font.title24.copyWith(color: Colors.white),
                  ),
                  // TODO : FCM 사용 전까지 숨김
                  // actions: [
                  //   IconButton(
                  //     onPressed: () {
                  //       context.push('/alarm');
                  //     },
                  //     padding: EdgeInsets.only(right: 24),
                  //     icon: Consumer(
                  //       builder: (context, ref, child) {
                  //         final alarmState = ref.watch(alarmViewModelProvider);
                  //         final alarmList = alarmState.alarmList;
                  //         final isNotRead =
                  //             alarmList?.any((e) => e.fcmIsRead == false) ?? false;

                  //         return Stack(
                  //           clipBehavior: Clip.none,
                  //           children: [
                  //             SvgPicture.asset(
                  //               'assets/icons/bell.svg',
                  //               width: 24,
                  //               height: 24,
                  //               fit: BoxFit.none,
                  //             ),
                  //             if (isNotRead)
                  //               Positioned(
                  //                 right: 0,
                  //                 top: 0,
                  //                 child: Container(
                  //                   width: 6,
                  //                   height: 6,
                  //                   decoration: BoxDecoration(
                  //                     color: Color(0xFFEA4D57),
                  //                     shape: BoxShape.circle,
                  //                   ),
                  //                 ),
                  //               ),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
      );
    }

    return null;
  }

  Widget _buildTab(
    BuildContext context,
    int index,
    bool selected,
    String iconName,
    String path,
    bool isHistory,
  ) {
    final colorSuffix = isHistory ? '_purple' : '';
    final stateSuffix = selected ? 'filled' : 'outlined';

    return GestureDetector(
      onTap: () {
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
