import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int selectedIndex = switch (location) {
      _ when location.startsWith('/history') => 1,
      _ when location.startsWith('/statistics') => 2,
      _ when location.startsWith('/setting') => 3,
      _ => 0,
    };

    final isHistory = location.startsWith('/history');

    return Scaffold(
      appBar: _buildAppBar(location),
      extendBody: location.startsWith('/home') ? true : false,
      extendBodyBehindAppBar: location.startsWith('/home') ? true : false,
      body: child,
      bottomNavigationBar: BottomAppBar(
        color: _buildBottomAppBarColor(location),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              onTap: () => context.push('/dream_intro'),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        isHistory
                            ? [Color(0xFFC77DFF), Color(0xFF9B30FF)]
                            : [Color(0xFF8C2EFF), Color(0xFF3B136B)],
                  ),
                ),
                child: const Icon(Icons.add, size: 32, color: Colors.white),
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

  AppBar? _buildAppBar(String location) {
    if (location.startsWith('/home')) {
      return AppBar(
        title: Text(
          'MONGBI',
          style: Font.title24.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        titleSpacing: 24,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: 알림 화면으로 이동
            },
            icon: SvgPicture.asset('assets/icons/bell.svg'),
          ),
        ],
      );
    } else if (location.startsWith('/statistics')) {
      return AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 24,
        centerTitle: false,
        title: Text('모몽의 꿈 통계', style: Font.title20),
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
        width: 28,
        height: 28,
      ),
    );
  }
}
