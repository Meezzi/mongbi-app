import 'package:flutter/material.dart';

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
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: enabled ? Colors.black : const Color(0xFFF5F4F4),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          '이렇게 불러줘',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: enabled ? Colors.white : Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
