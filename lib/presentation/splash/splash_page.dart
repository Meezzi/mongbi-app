import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 그라데이션
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

          // 콘텐츠 배치
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Column(
                  children: const [
                    Text(
                      '안녕, 난 몽비!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '꿈을 먹는 도깨비다몽',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),

                const Spacer(),
                Center(
                  child: Image.asset(
                    'assets/images/splash_mongbi.png',
                    width: 312,
                    height: 312,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
