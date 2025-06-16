import 'package:flutter/material.dart';
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

  final List<Map<String, dynamic>> onboardingData = [
    {
      'image': 'assets/images/screen1.webp',
      'title': '꿈과 기분을 기록하면,',
      'description': 'AI가 꿈 내용을 분석해 의미와\n심리적 신호를 알려줘요.',
    },
    {
      'image': 'assets/images/screen2.webp',
      'title': '해석을 받으면,',
      'description': '지금 내 마음속 상태를\n더 잘 이해할 수 있어요.',
    },
    {
      'image': 'assets/images/screen3.webp',
      'title': '감정에 따라,',
      'description': '몽비가 나만의 작은 챌린지를\n추천해줘요.',
    },
    {
      'image': 'assets/images/screen4.webp',
      'title': '시간이 지나면,',
      'description': '내 꿈과 감정의 흐름으 한눈에\n볼 수 있어요.',
    },
  ];

  void _onSkip() {
    Navigator.pushReplacementNamed(context, '/home');
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
    final _ = onboardingData[_currentPage];
    bool isLastPage = _currentPage == onboardingData.length - 1;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
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
                      const SizedBox(height: 150), // 상단 여백
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
              top: 16,
              right: 16,
              child: SkipButton(
                onTap: _onSkip,
                text: isLastPage ? '끝내기' : '건너뛰기',
              ),
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
                      colors: [
                        Color(0x00FAFAFA),
                        Color(0xFFFAFAFA), 
                      ],
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
