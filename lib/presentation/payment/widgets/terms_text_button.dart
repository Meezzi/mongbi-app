import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class TermsLinksRow extends StatelessWidget {

  const TermsLinksRow({
    super.key,
    required this.onServiceTermsPressed,
    required this.onPrivacyPolicyPressed,
  });
  final VoidCallback onServiceTermsPressed;
  final VoidCallback onPrivacyPolicyPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onServiceTermsPressed,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF76717A),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: Text(
            '서비스 이용약관',
            style: Font.body12.copyWith(color: const Color(0xFF76717A)),
          ),
        ),
        TextButton(
          onPressed: onPrivacyPolicyPressed,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF76717A),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: Text(
            '개인정보 처리 방침',
            style: Font.body12.copyWith(color: const Color(0xFF76717A)),
          ),
        ),
      ],
    );
  }
}
