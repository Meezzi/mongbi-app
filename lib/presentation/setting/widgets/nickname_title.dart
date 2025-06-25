import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class NicknameTitle extends StatelessWidget {
  const NicknameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '내가 너를 부를 수 있는\n별명을 알려줘몽!',
      textAlign: TextAlign.center,
      style: Font.title20.copyWith(color: const Color(0xFF1A181B)),
    );
  }
}
