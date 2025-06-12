import 'package:flutter/material.dart';

class NicknameTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String nickname;

  const NicknameTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.nickname,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F8F8),
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextField(
          controller: controller,
          maxLength: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '사용할 별명을 적어주세요',
            counterText: '',
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
