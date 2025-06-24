import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/calculate_time_remaining.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/home/widgets/completion_bottom_sheet.dart';
import 'package:mongbi_app/presentation/home/widgets/give_up_confirm_bottom_sheet.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';

class ChallengeCard extends ConsumerWidget {
  const ChallengeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenge = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.watch(homeViewModelProvider.notifier);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: ShapeDecoration(
        color: Color(0xFFFAFAFA).withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadows: [
          BoxShadow(
            color: Color(0xFF1A181B).withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(2, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFE8F9F7),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF64D4C7)),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Text(
                  challenge.challenge!.type,
                  style: Font.subTitle12.copyWith(color: Color(0xFF15AE9C)),
                ),
              ),
              Container(
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/alarm.svg',
                      width: 16,
                      height: 16,
                    ),
                    Text(
                      calculateTimeRemaining(),
                      style: Font.subTitle12.copyWith(
                        color: const Color(0xFFA6A1AA),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Text(
            challenge.challenge!.content,
            style: Font.title14.copyWith(color: const Color(0xFF0A5048)),
          ),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder:
                          (context) => GiveUpConfirmBottomSheet(
                            title: '정말로 포기할거야몽?',
                            subTitle: '소소한 행동으로 더 좋은 하루를 만들어보세요.',
                            onContinue: () {
                              context.pop();
                            },
                            onGiveUp: () {
                              context.pop();
                              homeViewModel.completeChallenge(
                                isComplete: false,
                              );
                            },
                          ),
                    );
                  },
                  child: Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE8F9F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x191A181B),
                          blurRadius: 10,
                          offset: Offset(2, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      '포기',
                      textAlign: TextAlign.center,
                      style: Font.title14.copyWith(
                        color: const Color(0xFF17BFAB),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap:
                      () => homeViewModel.completeChallenge(isComplete: true),
                  child: Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF17BFAB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x331A181B),
                          blurRadius: 10,
                          offset: Offset(2, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      '완료',
                      textAlign: TextAlign.center,
                      style: Font.title14.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
