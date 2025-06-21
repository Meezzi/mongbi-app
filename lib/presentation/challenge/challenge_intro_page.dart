import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_intro_mongbi_message_view.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';

class ChallengeIntroPage extends ConsumerWidget {
  const ChallengeIntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: MongbiMessageView()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: ActionButtonRow(
                leftText: '괜찮아',
                rightText: '선물이 뭐야?',
                onLeftPressed: () {
                  context.go('/home');
                },
                onRightPressed: () async {
                  // TODO: 사용자가 선택한 꿈 기분으로 변경
                  await ref
                      .read(challengeViewModelProvider.notifier)
                      .loadChallenges(1);
                  context.go('/challenge');
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
