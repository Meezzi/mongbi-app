import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_intro_mongbi_message_view.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';

class ChallengeIntroPage extends StatelessWidget {
  const ChallengeIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // TODO: 홈 화면으로 이동
                },
                onRightPressed: () {
                  // TODO: 챌린지 제안
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
