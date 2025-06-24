import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/onboarding/data/onboarding_data.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_button_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_image_widget.dart';
import 'package:mongbi_app/presentation/onboarding/widgets/onbording_exit_text_widget.dart';
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
    if (_currentPage == onboardingData.length) {
      context.go('/home');
    } else {
      _pageController.animateToPage(
        onboardingData.length,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
    final isLastPage = _currentPage == onboardingData.length;

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
              text: isLastPage ? '' : '건너뛰기',
              onTap: _onSkip,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            ExpandingDotsIndicator(
              currentPage: _currentPage,
              count: onboardingData.length + 1,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length + 1,
                    itemBuilder: (context, index) {
                      if (index < onboardingData.length) {
                        final item = onboardingData[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                                child: OnboardingImage(
                                  assetPath: item['image'],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              const CustomText(text: '그럼, 몽비와 함께'),
                              const CustomText(text: '꿈을 만나러 가볼까요?'),
                              const SizedBox(height: 40),
                              const OnboardingExitImage(
                                assetPath: 'assets/images/mongbi.webp',
                              ),
                              const SizedBox(height: 130),
                              FilledButtonWidget(
                                type: ButtonType.primary,
                                text: '시작할게',
                                onPress: () async {
                                  context.go('/home');
                                },
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        );
                      }
                    },
                  ),

                  // 마지막 페이지가 아닐 경우에만 배경 그라데이션 표시
                  if (!isLastPage)
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
          ],
        ),
      ),
    );
  }
}
