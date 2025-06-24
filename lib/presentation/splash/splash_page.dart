import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    FirebaseAnalytics.instance.logEvent(
      name: 'splash_viewed',
      parameters: {'screen': 'SplashPage'},
    );

    Future.delayed(const Duration(seconds: 3), () async {
      final viewModel = ref.read(splashViewModelProvider.notifier);
      await viewModel.checkLoginAndFetchUserInfo();

      final splashState = ref.read(splashViewModelProvider);

      if (!context.mounted) return;

      if (splashState.status == SplashStatus.success) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'splash_routed_home',
          parameters: {'status': 'success'},
        );
        context.go('/home');
      } else if (splashState.status == SplashStatus.needLogin) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'splash_routed_login',
          parameters: {'status': 'needLogin'},
        );
        context.go('/social_login');
      } else {
        await FirebaseAnalytics.instance.logEvent(
          name: 'splash_error',
          parameters: {'status': 'error'},
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('오류 발생')));
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
