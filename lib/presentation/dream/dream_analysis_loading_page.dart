import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';

class DreamAnalysisLoadingPage extends StatelessWidget {
  const DreamAnalysisLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFBC8FF).withValues(alpha: 0.4),
              Color(0xFFAE7CFF).withValues(alpha: 0.4),
              Color(0xFF37DAFF).withValues(alpha: 0.4),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '꿈 해석 중이야\n잠시만 기다려몽',
                  textAlign: TextAlign.center,
                  style: Font.title20,
                ),
                const SizedBox(height: 40),
                MongbiCharacter(size: 288),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
