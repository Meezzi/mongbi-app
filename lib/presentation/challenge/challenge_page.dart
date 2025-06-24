import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                '선물 골라봐몽!',
                style: Font.title20.copyWith(color: const Color(0xFF1A181B)),
              ),
              Expanded(
                child: challenges.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) =>
                          Center(child: Text('오류가 발생했습니다: $error')),
                  data:
                      (challenges) => Stack(
                        fit: StackFit.expand,
                        children: [
                          if (challenges.length >= 3) ...[
                            Positioned(
                              top: 44,
                              left: 0,
                              child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(challengeViewModelProvider.notifier)
                                      .selectChallenge(0);
                                  FirebaseAnalytics.instance.logEvent(
                                    name: 'challenge_selected',
                                    parameters: {
                                      'index': 0,
                                      'type': challenges[0].type,
                                      'screen': 'ChallengePage',
                                    },
                                  );
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
                              top: 220,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(challengeViewModelProvider.notifier)
                                      .selectChallenge(1);
                                  FirebaseAnalytics.instance.logEvent(
                                    name: 'challenge_selected',
                                    parameters: {
                                      'index': 1,
                                      'type': challenges[1].type,
                                      'screen': 'ChallengePage',
                                    },
                                  );
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
                              top: 410,
                              left: 10,
                              child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(challengeViewModelProvider.notifier)
                                      .selectChallenge(2);
                                  FirebaseAnalytics.instance.logEvent(
                                    name: 'challenge_selected',
                                    parameters: {
                                      'index': 2,
                                      'type': challenges[2].type,
                                      'screen': 'ChallengePage',
                                    },
                                  );
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
              ActionButtonRow(
                leftText: '흠 안할래',
                rightText: '이걸로 할래',
                onLeftPressed: () {
                  FirebaseAnalytics.instance.logEvent(
                    name: 'challenge_cancel',
                    parameters: {'screen': 'ChallengePage'},
                  );
                  showDialog(
                    context: context,
                    builder:
                        (context) => MongbiDialog(
                          content: '아앗, 아쉬워라\n꿈 잘먹었몽! 오늘도 힘내라몽',
                          buttonText: '고마워',
                          onSubmit: () {
                            context.pushReplacement('/home');
                          },
                        ),
                  );
                },
                onRightPressed: () async {
                  if (selectedIndex == null) {
                    FirebaseAnalytics.instance.logEvent(
                      name: 'challenge_not_selected',
                      parameters: {'screen': 'ChallengePage'},
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(customSnackBar('선물을 먼저 골라줘', 80));
                    return;
                  }

                  final selectedChallenge =
                      ref
                          .read(challengeViewModelProvider)
                          .value![selectedIndex];

                  await ref
                      .read(challengeViewModelProvider.notifier)
                      .saveChallenge();

                  await FirebaseAnalytics.instance.logEvent(
                    name: 'challenge_completed',
                    parameters: {
                      'index': selectedIndex,
                      'type': selectedChallenge.type,
                      'screen': 'ChallengePage',
                    },
                  );

                  await FirebaseAnalytics.instance.setUserProperty(
                    name: 'challenge_type',
                    value: selectedChallenge.type,
                  );

                  await showDialog(
                    context: context,
                    builder:
                        (context) => MongbiDialog(
                          content: '꿈 잘먹었몽!\n선물 완료하고, 오늘도 힘내라몽',
                          buttonText: '고마워',
                          onSubmit: () {
                            context.pushReplacement('/home');
                          },
                        ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
