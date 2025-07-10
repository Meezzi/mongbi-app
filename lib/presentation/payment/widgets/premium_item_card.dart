import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class PremiumBenefitCard extends StatelessWidget {

  const PremiumBenefitCard({
    super.key,
    required this.title,
    required this.description,
    required this.assetImage,
  });
  final String title;
  final String description;
  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EAFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Font.subTitle12.copyWith(color: const Color(0xFF29272A)),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Font.body12.copyWith(color: const Color(0xFF76717A)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            assetImage,
            width: 40,
            height: 40,
            color: const Color(0xFFCA9FFF), // 연보라 필터 (선택사항)
          ),
        ],
      ),
    );
  }
}
