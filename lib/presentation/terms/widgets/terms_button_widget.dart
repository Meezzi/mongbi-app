import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class ConfirmButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const ConfirmButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => states.contains(MaterialState.disabled)
                ? const Color(0x60F5F4F5) // 비활성화 색상
                : const Color(0xFF8C2EFF), // 활성화 색상
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => states.contains(MaterialState.disabled)
                ? const Color(0xFFD6D4D8)
                : Colors.white,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          overlayColor: MaterialStateProperty.all(Colors.transparent), // 눌렀을 때 물결 제거 (옵션)
        ),
        child: Text(
          '확인했어',
          style: Font.title18.copyWith(
            fontSize: getResponsiveRatioByWidth(context, 18),
            color: isEnabled ? Colors.white : const Color(0xFFD6D4D8),
          ),
        ),
      ),
    );
  }
}
