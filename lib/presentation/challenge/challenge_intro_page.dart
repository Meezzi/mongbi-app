import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/responsive_layout.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_intro_mongbi_message_view.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class ChallengeIntroPage extends ConsumerWidget {
  const ChallengeIntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamScore = ref.read(selectedDreamScoreProvider);
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: ResponsiveLayout.getWidth(context),
            child: Column(
              children: [
                Expanded(child: MongbiMessageView()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: ActionButtonRow(
                    leftText: '괜찮아',
                    rightText: '선물이 뭐야?',
                    onLeftPressed: () {
                      context.go('/home');
                    },
                    onRightPressed: () async {
                      await ref
                          .read(challengeViewModelProvider.notifier)
                          .loadChallenges(dreamScore);
                      context.pushReplacement('/challenge');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
