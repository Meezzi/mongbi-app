import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_status.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    AnalyticsHelper.logScreenView('스플래시_페이지');

    Future.delayed(const Duration(seconds: 3), () async {
      final viewModel = ref.read(splashViewModelProvider.notifier);
      await viewModel.checkLoginAndFetchUserInfo();

      final splashState = ref.read(splashViewModelProvider);

      if (!context.mounted) return;

      if (splashState.status == SplashStatus.successWithReminder) {
        await AnalyticsHelper.logEvent(
          '스플래시_홈_이동',
          {'상태': '성공_리마인드_있음'},
        );
        context.go('/home');
      } else if (splashState.status == SplashStatus.successWithoutReminder) {
        await AnalyticsHelper.logEvent(
          '스플래시_리마인드_설정_필요',
          {'상태': '성공_리마인드_없음'},
        );
        context.go('/remindtime_setting');
      } else if (splashState.status == SplashStatus.needLogin) {
        await AnalyticsHelper.logEvent(
          '스플래시_로그인_필요',
          {'상태': '로그인_필요'},
        );
        context.go('/social_login');
      } else {
        await AnalyticsHelper.logEvent(
          '스플래시_에러',
          {'상태': '에러'},
        );
        context.go('/social_login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF08063A),
                  Color(0xFF3B7EBA),
                  Color(0xFF3FAEF4),
                  Color(0xFF9AE4D6),
                ],
                stops: [0.2, 0.42, 0.72, 0.93],
              ),
            ),
          ),
          Image.asset(
            'assets/images/star.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '안녕, 난 몽비!',
                  style: Font.title24.copyWith(color: Colors.white),
                ),
                Text(
                  '꿈을 먹는 도깨비다몽',
                  style: Font.title24.copyWith(color: Colors.white),
                ),
                SizedBox(height: screenHeight * 0.035),
                FloatingAnimationWidget(
                  child: Image.asset(
                    'assets/images/splash_mongbi.webp',
                    width: screenHeight * 0.38,
                    height: screenHeight * 0.38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

