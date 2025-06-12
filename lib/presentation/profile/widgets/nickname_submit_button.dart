import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class NicknameSubmitButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onTap;

  const NicknameSubmitButton({
    super.key,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: enabled ? Color(0xFF8C2EFF) : const Color(0xF5F5F4F5),
            borderRadius: BorderRadius.circular(40),
            boxShadow: !enabled
                ? [
                    BoxShadow(
                      color: const Color(0x1A1A181B), // 10% 불투명도 그림자
                      offset: const Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: Text(
            '이렇게 불러줘',
            textAlign: TextAlign.center,
            style: Font.title18.copyWith(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ),
    );
  }
}
