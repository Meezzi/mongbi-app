import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/home/widgets/speech_bubble.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MONGBI',
          style: Font.title24.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: 알림 화면으로 이동
            },
            icon: SvgPicture.asset('assets/icons/bell.svg', fit: BoxFit.cover),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF08063A),
              Color(0xFF54BAF9),
              Color(0xFF8C8CFF),
              Color(0xFFF56CFF),
            ],
            stops: [0.2, 0.5, 0.78, 0.96],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/home_cloude.svg',
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/home_star.png',
                fit: BoxFit.contain,
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSpeechBubble(text: '킁킁... 좋은 꿈 냄새 난다몽'),
                  MongbiCharacter(size: 288),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
