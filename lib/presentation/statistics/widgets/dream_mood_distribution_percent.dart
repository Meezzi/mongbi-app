import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class DreamMoodDistributionPercent extends StatelessWidget {
  DreamMoodDistributionPercent({
    super.key,
    required this.isFirst,
    required this.type,
    required this.percent,
  });

  final bool isFirst;
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
    return SizedBox(
      width: 65,
      child: Row(
        children: [
          SvgPicture.asset(iconMap[type]!, fit: BoxFit.cover, width: 24),
          SizedBox(width: 6),
          Text(
            isFirst ? '00%' : '$percent%',
            style: Font.subTitle12.copyWith(
              color: isFirst ? Color(0xFFA6A1AA) : Color(0xff1A181B),
            ),
          ),
        ],
      ),
    );
  }
}
