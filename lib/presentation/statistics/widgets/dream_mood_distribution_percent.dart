import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class DreamMoodDistributionPercent extends StatelessWidget {
  DreamMoodDistributionPercent({
    super.key,
    required this.type,
    required this.percent,
  });

  final String type;
  final int percent;
  final Map<String, String> iconMap = {
    'very_good': 'assets/icons/very_good.svg',
    'good': 'assets/icons/good.svg',
    'ordinary': 'assets/icons/ordinary.svg',
    'bad': 'assets/icons/bad.svg',
    'very_bad': 'assets/icons/very_bad.svg',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconMap[type]!, fit: BoxFit.cover, width: 24),
        SizedBox(width: 8),
        Text(
          '$percent%',
          style: Font.subTitle12.copyWith(color: Color(0xFFA6A1AA)),
        ),
      ],
    );
  }
}
