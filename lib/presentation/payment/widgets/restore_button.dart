import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class RestorePurchaseButton extends StatelessWidget {

  const RestorePurchaseButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Color(0xFFDBBEFF), width: 2),
         
        ),
        child: Center(
          child: Text(
            '구매 복원하기',
            style: Font.subTitle12.copyWith(color: const Color(0xFFB273FF)),
          ),
        ),
      ),
    );
  }
}
