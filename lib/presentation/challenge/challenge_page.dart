import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/responsive_layout.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_container.dart';
import 'package:mongbi_app/presentation/challenge/widgets/mongbi_dialog.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';

class ChallengePage extends ConsumerWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenges = ref.watch(challengeViewModelProvider);
    final selectedIndex =
        ref.watch(challengeViewModelProvider.notifier).selectedChallengeIndex;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: ResponsiveLayout.getWidth(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text(
                    '선물 골라봐몽!',
                    style: Font.title20.copyWith(
                      color: const Color(0xFF1A181B),
                    ),
                  ),
                  Expanded(
                    child: challenges.when(
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (error, stack) =>
                              Center(child: Text('오류가 발생했습니다: $error')),
                      data:
                          (challenges) => Stack(
                            fit: StackFit.expand,
                            children: [
                              if (challenges.length >= 3) ...[
                                Positioned(
                                  top: screenHeight * 0.05,
                                  left: screenWidth * 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(
                                            challengeViewModelProvider.notifier,
                                          )
                                          .selectChallenge(0);
                                      AnalyticsHelper.logEvent('챌린지_선택', {
                                        '인덱스': 0,
                                        '타입': challenges[0].type,
                                        '화면_이름': 'ChallengePage',
                                      });
                                    },
                                    child: ChallengeContainer(
                                      title: challenges[0].type,
                                      content: challenges[0].content,
                                      containerColor: const Color(0xFFB7EBE5),
                                      rotationAngle: -0.14,
                                      isSelected: selectedIndex == 0,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: screenHeight * 0.27,
                                  right: screenWidth * 0.03,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(
                                            challengeViewModelProvider.notifier,
                                          )
                                          .selectChallenge(1);
                                      AnalyticsHelper.logEvent('챌린지_선택', {
                                        '인덱스': 1,
                                        '타입': challenges[1].type,
                                        '화면_이름': 'ChallengePage',
                                      });
                                    },
                                    child: ChallengeContainer(
                                      title: challenges[1].type,
                                      content: challenges[1].content,
                                      containerColor: const Color(0xFF94E2D8),
                                      rotationAngle: 0.14,
                                      isSelected: selectedIndex == 1,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: screenHeight * 0.5,
                                  left: screenWidth * 0.03,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(
                                            challengeViewModelProvider.notifier,
                                          )
                                          .selectChallenge(2);
                                      AnalyticsHelper.logEvent('챌린지_선택', {
                                        '인덱스': 2,
                                        '타입': challenges[2].type,
                                        '화면_이름': 'ChallengePage',
                                      });
                                    },
                                    child: ChallengeContainer(
                                      title: challenges[2].type,
                                      content: challenges[2].content,
                                      containerColor: const Color(0xFF64D4C7),
                                      rotationAngle: -0.14,
                                      isSelected: selectedIndex == 2,
                                    ),
                                  ),
                                ),
                              ] else
                                const Center(child: Text('챌린지가 부족합니다.')),
                            ],
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ActionButtonRow(
                      leftText: '흠 안할래',
                      rightText: '이걸로 할래',
                      onLeftPressed: () {
                        AnalyticsHelper.logButtonClick(
                          '챌린지_취소',
                          'ChallengePage',
                        );
                        showDialog(
                          context: context,
                          builder:
                              (context) => MongbiDialog(
                                title: '홈으로 돌아갈래몽?',
                                content: '선물을 선택하지 않아도,\n오늘 꿈은 더 이상 먹지 못해!',
                                buttonText: '고마워',
                                onSubmit: () {
                                  context.go('/home');
                                },
                              ),
                        );
                      },
                      onRightPressed: () async {
                        if (selectedIndex == null) {
                          await AnalyticsHelper.logEvent('챌린지_미선택', {
                            '화면_이름': 'ChallengePage',
                          });
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(customSnackBar('선물을 먼저 골라줘', 80, 2));
                          return;
                        }

                        final selectedChallenge =
                            ref
                                .read(challengeViewModelProvider)
                                .value![selectedIndex];

                        await AnalyticsHelper.logEvent('챌린지_완료', {
                          '인덱스': selectedIndex,
                          '타입': selectedChallenge.type,
                          '화면_이름': 'ChallengePage',
                        });

                        await AnalyticsHelper.logEvent('유저_속성_설정', {
                          '속성_이름': 'challenge_type',
                          '속성_값': selectedChallenge.type,
                        });

                        await showDialog(
                          context: context,
                          builder:
                              (context) => MongbiDialog(
                                title: '꿈 잘먹었어몽!',
                                content: '선물을 완료해서\n더 행복한 하루 보내자!',
                                buttonText: '고마워',
                                onSubmit: () async {
                                  await ref
                                      .read(challengeViewModelProvider.notifier)
                                      .saveChallenge();

                                  context.go('/home');
                                },
                              ),
                        );
                      },
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
}
