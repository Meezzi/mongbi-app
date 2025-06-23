import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class ActionButtonRow extends StatelessWidget {
  const ActionButtonRow({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.onLeftPressed,
    required this.onRightPressed,
  });

  final String leftText;
  final String rightText;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RoundedShadowButton(
            onPressed: onLeftPressed,
            backgroundColor: const Color(0xFFF4EAFF),
            textColor: const Color(0xFFB273FF),
            shadowAlpha: 10,
            text: leftText,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RoundedShadowButton(
            onPressed: onRightPressed,
            backgroundColor: const Color(0xFF8C2EFF),
            textColor: Colors.white,
            shadowAlpha: 20,
            text: rightText,
          ),
        ),
      ],
    );
  }
}

class RoundedShadowButton extends StatelessWidget {
  const RoundedShadowButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.shadowAlpha,
    required this.text,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final int shadowAlpha;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1A181B).withAlpha(shadowAlpha),
            offset: const Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Text(text, style: Font.title18.copyWith(color: textColor)),
      ),
    );
  }
}
