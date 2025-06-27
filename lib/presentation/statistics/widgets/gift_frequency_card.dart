import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class GiftFrequencyCard extends StatelessWidget {
  const GiftFrequencyCard({
    super.key,
    required this.isFirst,
    required this.challengeSuccessRate,
  });

  final bool isFirst;
  final int challengeSuccessRate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 124,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Color(0x0D7F2AE8),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('선물 달성률', style: Font.title14.copyWith(fontSize: 14)),
            Text(
              '$challengeSuccessRate%',
              style: Font.title28.copyWith(
                color: isFirst ? Color(0xFFA6A1AA) : Color(0xFF1A181B),
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
