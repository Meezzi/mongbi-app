import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_intro_action_button.dart';
import 'package:mongbi_app/presentation/challenge/widgets/challenge_intro_mongbi_message_view.dart';

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
              child: Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      onPressed: () {
                        // TODO: 홈 화면으로 이동
                      },
                      backgroundColor: const Color(0xFFF4EAFF),
                      textColor: const Color(0xFFB273FF),
                      shadowAlpha: 10,
                      text: '괜찮아',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ActionButton(
                      onPressed: () {
                        // TODO: 챌린지 제안
                      },
                      backgroundColor: const Color(0xFF8C2EFF),
                      textColor: Colors.white,
                      shadowAlpha: 20,
                      text: '선물이 뭐야?',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
