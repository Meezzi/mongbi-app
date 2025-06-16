import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/auth/widgets/text_widgets.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_button_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_image_widget.dart';

class OnboardingFinalPage extends StatelessWidget {
  const OnboardingFinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 64),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CustomText(
                    text: '그럼, 몽비와 함께\n꿈을 만나러 가볼까요?',
                  ),
                ),
                const SizedBox(height: 40),
                const OnboardingExitImage(
                  assetPath: 'assets/images/character_mongbi.png',
                ),
              ],
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 32,
              child: OnbordingExitButtonWidget(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
