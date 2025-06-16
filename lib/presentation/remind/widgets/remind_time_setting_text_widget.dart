import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.align = TextAlign.start,
  });

  final String text;
  final Color? color;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: Font.title20.copyWith(
        color: color ?? const Color(0xFF1A181B),
      ),
    );
  }
}
