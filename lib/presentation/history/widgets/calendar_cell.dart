import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class CalendarCell extends ConsumerWidget {
  const CalendarCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.cellWidth,
    required this.circleWidth,
  });

  final DateTime day;
  final bool isSelected;
  final double cellWidth;
  final double circleWidth;
  final Map<String, String> iconPathMap = const {
    '1': 'assets/icons/very_bad.svg',
    '2': 'assets/icons/bad.svg',
    '3': 'assets/icons/ordinary.svg',
    '4': 'assets/icons/good.svg',
    '5': 'assets/icons/very_good.svg',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyVm = ref.read(historyViewModelProvider.notifier);
    List<History> searchedHistory = historyVm.searchDateTime(day);
    String? iconPath;
    if (searchedHistory.isNotEmpty) {
      iconPath = iconPathMap['${searchedHistory.first.dreamScore}'];
    }
    return Container(
      width: cellWidth,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF3B136B) : null,
        borderRadius: isSelected ? BorderRadius.circular(999) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: circleWidth,
            height: circleWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child:
                iconPath != null
                    ? SvgPicture.asset(iconPath, fit: BoxFit.cover)
                    : null,
          ),
          SizedBox(height: 4),
          Text(
            '${day.day}',
            style: Font.subTitle14.copyWith(
              color: isSelected ? Colors.white : Color(0xFFB273FF),
            ),
          ),
        ],
      ),
    );
  }
}
