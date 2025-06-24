import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';

class DreamAnalysisResultPage extends StatefulWidget {
  const DreamAnalysisResultPage({super.key});

  @override
  State<DreamAnalysisResultPage> createState() =>
      _DreamAnalysisResultPageState();
}

class _DreamAnalysisResultPageState extends State<DreamAnalysisResultPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.pushReplacement('/dream_interpretation');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFDFF), Color(0xFFEFD3FF), Color(0xFFD1FFFD)],
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
                FloatingAnimationWidget(
                  child: Image.asset(
                    'assets/images/splash_mongbi.webp',
                    width: screenHeight * 0.28,
                    height: screenHeight * 0.28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
