import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
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
      extendBodyBehindAppBar: location.startsWith('/home'),
      extendBody: true,
      body: child,
      bottomNavigationBar: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: BottomAppBar(
          color: _buildBottomAppBarColor(location),
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab(context, 0, selectedIndex == 0, 'home', '/home', isHistory),
                  _buildTab(context, 1, selectedIndex == 1, 'record', '/history', isHistory),
                  _buildCenterAddButton(context, ref, isHistory),
                  _buildTab(context, 2, selectedIndex == 2, 'statistics', '/statistics', isHistory),
                  _buildTab(context, 3, selectedIndex == 3, 'user', '/setting', isHistory),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _buildScaffoldBackgroundColor(String location) {
    if (location.startsWith('/setting')) return const Color(0xFFFCF6FF);
    if (location.startsWith('/statistics')) return Colors.white;
    return const Color(0xFFFAFAFA);
  }

  Color _buildBottomAppBarColor(String location) {
    return switch (location) {
      '/home' => Colors.white,
      '/statistics' => Colors.white,
      '/history' => const Color(0xFF3B136B),
      '/setting' => const Color(0xFFFCF6FF),
      _ => Colors.white,
    };
  }

  AppBar? _buildAppBar(BuildContext context, String location) {
    if (location.startsWith('/home')) {
      return AppBar(
        title: Text('MONGBI', style: Font.title24.copyWith(color: Colors.white)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        titleSpacing: 24,
        elevation: 0,
      );
    } else if (location.startsWith('/setting')) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 24,
        title: Text('마이페이지', style: Font.title20),
        centerTitle: false,
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
      onTap: () => context.go(path),
      child: SvgPicture.asset(
        'assets/icons/$iconName${colorSuffix}_$stateSuffix.svg',
        width: 24,
        height: 24,
      ),
    );
  }

  Widget _buildCenterAddButton(BuildContext context, WidgetRef ref, bool isHistory) {
    return GestureDetector(
      onTap: () async {
        final uid = await SecureStorageService().getUserIdx();
        if (uid == null) return;

        final canWrite = await ref.read(canWriteDreamTodayUseCaseProvider).execute(uid);

        if (canWrite) {
          await context.push('/dream_intro');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar('오늘은 이미 했어, 배불러몽!', 16, 2),
          );
        }
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A181B).withAlpha(51),
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: isHistory ? [0.1, 1.0] : [0, 1.0],
            colors: isHistory
                ? [const Color(0xFFEAC9FA), const Color(0xFF8C2EFF)]
                : [const Color(0xFF8C2EFF), const Color(0xFF3B136B)],
          ),
        ),
        child: SvgPicture.asset(
          'assets/icons/add.svg',
          width: 24,
          height: 24,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
