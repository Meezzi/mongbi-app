import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class DreamFrequencyCard extends StatelessWidget {
  const DreamFrequencyCard({
    super.key,
    required this.frequency,
    required this.totalDays,
  });

  final int frequency;
  final int totalDays;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: getResponsiveRatioByWidth(context, 124),
        padding: EdgeInsets.all(getResponsiveRatioByWidth(context, 24)),
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
            Text(
              '꿈을 꾼 횟수',
              style: Font.title14.copyWith(
                fontSize: getResponsiveRatioByWidth(context, 14),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$frequency일',
                  style: Font.title24.copyWith(
                    fontSize: getResponsiveRatioByWidth(context, 24),
                    height: 27 / 24,
                  ),
                ),
                SizedBox(width: getResponsiveRatioByWidth(context, 4)),
                Text('/$totalDays일', style: Font.subTitle12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
