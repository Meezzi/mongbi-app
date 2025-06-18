import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_container.dart';
import 'package:mongbi_app/presentation/challenge/widgets/mongbi_dialog.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                '선물 골라봐몽!',
                style: Font.title20.copyWith(color: Color(0xFF1A181B)),
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 80,
                      left: 0,
                      child: ChallengeContainer(
                        title: '감각 리셋형',
                        content: '오늘의 식사를 아주 맛있어 보이게 찍어보기',
                        containerColor: Color(0xFFB7EBE5),
                        rotationAngle: -0.14,
                      ),
                    ),
                    Positioned(
                      top: 250,
                      right: 10,
                      child: ChallengeContainer(
                        title: '감정 표현형',
                        content: '오늘의 식사를 아주 맛있어 보이게 찍어보기',
                        containerColor: Color(0xFF94E2D8),
                        rotationAngle: 0.14,
                      ),
                    ),
                    Positioned(
                      top: 450,
                      left: 10,
                      child: ChallengeContainer(
                        title: '심리 안정형',
                        content: '오늘의 식사를 아주 맛있어 보이게 찍어보기',
                        containerColor: Color(0xFF64D4C7),
                        rotationAngle: -0.14,
                      ),
                    ),
                  ],
                ),
              ),
              ActionButtonRow(
                leftText: '흠 안할래',
                rightText: '이걸로 할래',
                onLeftPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => MongbiDialog(
                          content: '아앗, 아쉬워라\n꿈 잘먹었몽! 오늘도 힘내라몽',
                          buttonText: '고마워',
                          onSubmit: () {
                            context.go('/home');
                          },
                        ),
                  );
                },
                onRightPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => MongbiDialog(
                          content: '꿈 잘먹었몽!\n선물 완료하고, 오늘도 힘내라몽',
                          buttonText: '고마워',
                          onSubmit: () {
                            // TODO: 저장 로직
                          },
                        ),
                  );
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
