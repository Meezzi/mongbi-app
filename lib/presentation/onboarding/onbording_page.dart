import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/onboarding/data/onboarding_data.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_image_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_indicator_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_skip_button_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_text_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onSkip() {
    context.push('/onbording_exit_page');
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == onboardingData.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 24, 16),
            child: SkipButton(
              text: isLastPage ? '끝내기' : '건너뛰기',
              onTap: _onSkip,
            ),
          ),
        ],
        
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final item = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      ExpandingDotsIndicator(
                        currentPage: _currentPage,
                        count: onboardingData.length,
                      ),
                      const SizedBox(height: 24),
                      OnboardingText(
                        text: item['title'],
                        type: OnboardingTextType.title,
                      ),
                      const SizedBox(height: 8),
                      OnboardingText(
                        text: item['description'],
                        type: OnboardingTextType.description,
                      ),
                      const SizedBox(height: 80),
                      Expanded(
                        child: OnboardingImage(assetPath: item['image']),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  height: 145,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00FAFAFA), Color(0xFFFAFAFA)],
                      stops: [0.0, 0.81],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
