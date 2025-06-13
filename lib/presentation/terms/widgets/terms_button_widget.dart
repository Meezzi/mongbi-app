import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class ConfirmButton extends StatelessWidget {

  const ConfirmButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? const Color(0x60F5F4F5)
                : const Color(0xFF8C2EFF),
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? const Color(0xFFD6D4D8)
                : Colors.white,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent), 
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
