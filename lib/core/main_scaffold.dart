import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/providers/dream_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  final GlobalKey _dreamButtonKey = GlobalKey();
  bool _showTutorial = false;

  @override
  void initState() {
    super.initState();
    _checkAndShowShowcase();
  }

  Future<void> _checkAndShowShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownShowcase = prefs.getBool('hasShownShowcase') ?? false;

    if (!hasShownShowcase) {
      setState(() => _showTutorial = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_dreamButtonKey]);
      });
      await prefs.setBool('hasShownShowcase', true);
    }
  }

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

    return Stack(
      children: [
        Scaffold(
          backgroundColor: _buildScaffoldBackgroundColor(location),
          appBar: _buildAppBar(context, location),
          extendBodyBehindAppBar: location.startsWith('/home'),
          body: widget.child,
          bottomNavigationBar: BottomAppBar(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: _buildBottomAppBarColor(location),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab(context, 0, selectedIndex == 0, 'home', '/home', isHistory),
                _buildTab(context, 1, selectedIndex == 1, 'record', '/history', isHistory),

                Showcase.withWidget(
                  key: _dreamButtonKey,
                  height: 200,
                  width: 380,
                  targetShapeBorder: const CircleBorder(),
                  disableMovingAnimation: true,
                  container: SvgPicture.asset(
                    'assets/images/tutorail_mseeage.svg',
                    fit: BoxFit.cover,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final uid = await SecureStorageService().getUserIdx();
                      if (uid == null) return;

                      final canWrite = await ref
                          .read(canWriteDreamTodayUseCaseProvider)
                          .execute(uid);

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
                        border: Border.all(color: Colors.white, width: 3),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: isHistory ? [0.1, 1.0] : [0, 1.0],
                          colors: isHistory
                              ? [const Color(0xFFEAC9FA), const Color(0xFF8C2EFF)]
                              : [const Color(0xFF8C2EFF), const Color(0xFF3B136B)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1A181B).withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/add.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ),

                _buildTab(context, 2, selectedIndex == 2, 'statistics', '/statistics', isHistory),
                _buildTab(context, 3, selectedIndex == 3, 'user', '/setting', isHistory),
              ],
            ),
          ),
        ),

        if (_showTutorial)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 12,
            child: GestureDetector(
              onTap: () {
                ShowCaseWidget.of(context).dismiss();
                setState(() => _showTutorial = false);
              },
              child: SvgPicture.asset(
                'assets/icon/cancel.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
      ],
    );
  }

  Color _buildScaffoldBackgroundColor(String location) {
    if (location.startsWith('/setting')) return const Color(0xFFFCF6FF);
    if (location.startsWith('/statistics')) return Colors.white;
    return const Color(0xFFFAFAFA);
  }

  Color _buildBottomAppBarColor(String location) {
    switch (location) {
      case '/home':
      case '/statistics':
        return Colors.white;
      case '/history':
        return const Color(0xFF3B136B);
      case '/setting':
        return const Color(0xFFFCF6FF);
      default:
        return Colors.white;
    }
  }

  AppBar? _buildAppBar(BuildContext context, String location) {
    if (location.startsWith('/home')) {
      return AppBar(
        title: Text(
          'MONGBI',
          style: Font.title24.copyWith(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 24,
      );
    } else if (location.startsWith('/setting')) {
      return AppBar(
        title: Text('마이페이지', style: Font.title20),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 24,
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
}
