import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class GiftFrequencyCard extends StatelessWidget {
  const GiftFrequencyCard({super.key, required this.frequency});

  final int frequency;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: getResponsiveRatioByWidth(context, 124),
        padding: EdgeInsets.all(getResponsiveRatioByWidth(context, 24)),
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
            Text(
              '선물 달성률',
              style: Font.title14.copyWith(
                fontSize: getResponsiveRatioByWidth(context, 14),
              ),
            ),
            Text(
              '$frequency%',
              style: Font.title28.copyWith(
                fontSize: getResponsiveRatioByWidth(context, 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
