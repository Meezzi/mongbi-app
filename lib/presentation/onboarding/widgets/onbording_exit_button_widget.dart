import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class OnbordingExitButtonWidget extends StatelessWidget {
  const OnbordingExitButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF8C2EFF),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            '시작할게',
            textAlign: TextAlign.center,
            style: Font.title18.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
