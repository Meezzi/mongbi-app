import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.onTap, this.text = '건너뛰기'});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: Font.subTitle14.copyWith(color: Color(0xFF76717A)),
          ),
        ),
      ),
    );
  }
}
