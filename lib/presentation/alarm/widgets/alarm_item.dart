import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class AlarmItem extends StatelessWidget {
  const AlarmItem({
    super.key,
    required this.type,
    required this.date,
    required this.content,
    required this.isConfirmed,
  });

  final String type;
  final String date;
  final String content;
  final bool isConfirmed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    type,
                    style: Font.title14.copyWith(color: Color(0xFF76717A)),
                  ),
                  if (isConfirmed)
                    Positioned(
                      right: -4,
                      top: 0,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Color(0xFFEA4D57),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              Text(date, style: Font.body12.copyWith(color: Color(0xFF76717A))),
            ],
          ),
          SizedBox(height: 4),
          Text(content, style: Font.body14.copyWith(color: Color(0xFF1A181B))),
        ],
      ),
    );
  }
}
