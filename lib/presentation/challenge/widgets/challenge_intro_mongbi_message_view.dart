import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';

class MongbiMessageView extends StatelessWidget {
  const MongbiMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '선물을 준비했몽, 골라봐!\n따라하면 기분이 좋아질거야!',
          style: Font.title20.copyWith(color: Color(0xFF1A181B)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 48),
        FloatingAnimationWidget(child: MongbiCharacter(size: 288)),
      ],
    );
  }
}
