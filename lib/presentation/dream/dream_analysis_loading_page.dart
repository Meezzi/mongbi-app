import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/responsive_layout.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';
import 'package:mongbi_app/providers/dream_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DreamAnalysisLoadingPage extends ConsumerStatefulWidget {
  const DreamAnalysisLoadingPage({super.key, required this.isFirst});

  final bool isFirst;

  @override
  ConsumerState<DreamAnalysisLoadingPage> createState() =>
      _DreamAnalysisLoadingPageState();
}

class _DreamAnalysisLoadingPageState
    extends ConsumerState<DreamAnalysisLoadingPage> {
  @override
  void initState() {
    super.initState();

    _analyzeDream();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: ResponsiveLayout.getWidth(context),
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
      ),
    );
  }

  Future<void> _analyzeDream() async {
    try {
      await ref.read(dreamWriteViewModelProvider.notifier).submitDream();
      if (mounted) {
        context.pushReplacement(
          '/dream_analysis_result?isFirst=${widget.isFirst}',
        );
      }
    } catch (e, s) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnackBar('꿈 해석 중 오류가 발생했어요.', 80, 2));

        await Sentry.captureException(e, stackTrace: s);

        context.pop();
      }
    }
  }
}
