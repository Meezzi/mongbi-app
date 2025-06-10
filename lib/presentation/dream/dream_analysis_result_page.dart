import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';

class DreamAnalysisResultPage extends StatelessWidget {
  const DreamAnalysisResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFDFF),
              Color(0xFFEFD3FF),
              Color(0xFFD1FFFD),
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
                  '다됐다몽!\n',
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
