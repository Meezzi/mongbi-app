import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        late final bool aggreedState;
        late final bool loginState;
        final prefs = await SharedPreferences.getInstance();
        aggreedState = prefs.getBool('isaggreed') ?? false;
        loginState = prefs.getBool('isLogined') ?? false;

        if (loginState) {
          context.go('/home');
        } else if (loginState == true && !aggreedState) {
          //홈 화면으로 이동후 바텀 시트 출력되게
        } else {
          context.go('/social_login');
        }
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
            'assets/images/star.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '안녕, 난 몽비!\n꿈을 먹는 도깨비다몽',
                  style: Font.title24.copyWith(color: Colors.white),
                ),
                SizedBox(height: screenHeight * 0.035),
                FloatingAnimationWidget(
                  child: Image.asset(
                    'assets/images/splash_mongbi.png',
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
