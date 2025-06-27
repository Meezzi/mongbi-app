import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class DreamFrequencyCard extends StatelessWidget {
  const DreamFrequencyCard({
    super.key,
    required this.isFirst,
    required this.frequency,
    required this.totalDays,
  });

  final bool isFirst;
  final int frequency;
  final int totalDays;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 124,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Color(0x0D7F2AE8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('꿈을 꾼 횟수', style: Font.title14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$frequency일',
                  style: Font.title24.copyWith(
                    height: 27 / 24,
                    color: isFirst ? Color(0xFFA6A1AA) : Color(0xFF1A181B),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '/$totalDays일',
                  style: Font.subTitle12.copyWith(
                    color: isFirst ? Color(0xFF57525B) : Color(0xFF1A181B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
