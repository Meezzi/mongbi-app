import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class PremiumBottomBar extends StatelessWidget {
  final VoidCallback onPressed;

  const PremiumBottomBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8C2EFF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 0,
              ),
              child: Text(
                '무료 체험 시작하기',
                style: Font.title14.copyWith(color: const Color(0xFFFFFFFF)),
              ),
            ),
          ),
          const SizedBox(height: 10),
           Text(
            '무료 체험 종료 후 연간 ₩33,000원이 결제되며, \n언제든 취소가 가능해요.',
            textAlign: TextAlign.center,
            style: Font.body12.copyWith(color: const Color(0xFF76717A)),
          ),
        ],
      ),
    );
  }
}
