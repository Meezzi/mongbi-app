import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 51,
      height: 36,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            '건너뛰기',
            style: Font.subTitle14.copyWith(color: Color(0xFF76717A)),
          ),
        ),
      ),
    );
  }
}
