import 'package:flutter/material.dart';

class TermsHeaderText extends StatelessWidget {
  const TermsHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '몽비 이용을 위한\n이용약관 동의가 필요해몽',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
