import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_button_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_image_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_text_widget.dart';

class OnboardingExitPage extends StatelessWidget {
  const OnboardingExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 56,
        titleSpacing: 24,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const CustomText(text: '그럼, 몽비와 함께'),
              const CustomText(text: '꿈을 만나러 가볼까요?'),
              const SizedBox(height: 40),
              const OnboardingExitImage(assetPath: 'assets/images/mongbi.webp'),
              const Spacer(),
              OnbordingExitButtonWidget(
                onTap: () {
                  context.go('/home');
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
