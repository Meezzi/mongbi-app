import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/features/auth/presentation/pages/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/features/common/floating_animation_widget.dart';

class MongbiMessageView extends StatelessWidget {
  const MongbiMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '선물을 준비했몽, 골라봐!',
          style: Font.title20.copyWith(color: Color(0xFF1A181B)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          '감정에 어울리는 작은 챌린지를 통해,\n하루를 기분 좋게 시작할 수 있어요.',
          textAlign: TextAlign.center,
          style: Font.body16.copyWith(color: Color(0xFF636363)),
        ),
        SizedBox(height: 48),
        FloatingAnimationWidget(child: MongbiCharacter(size: 288)),
      ],
    );
  }
}
