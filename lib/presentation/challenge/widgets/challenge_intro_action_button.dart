import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
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

  static const Color _shadowColor = Color(0xFF1A181B);
  static const double _buttonHeight = 56.0;
  static const double _borderRadius = 999.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _buttonHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: _shadowColor.withAlpha(shadowAlpha),
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
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
        child: Text(text, style: Font.title18.copyWith(color: textColor)),
      ),
    );
  }
}
