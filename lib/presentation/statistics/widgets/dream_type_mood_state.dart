import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/presentation/statistics/widgets/common_box.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_type_mood_state_row.dart';
import 'package:mongbi_app/presentation/statistics/widgets/mood_state_info_modal.dart';

class DreamTypeMoodState extends StatelessWidget {
  DreamTypeMoodState({
    super.key,
    required this.isMonth,
    required this.moodState,
  });

  final infoModal = MoodStateInfoModal();
  final bool isMonth;
  final MoodState? moodState;

  @override
  Widget build(BuildContext context) {
    return CommonBox(
      title: Row(
        children: [
          Text(
            '꿈 유형별 기분 상태',
            style: Font.title14.copyWith(
              fontSize: getResponsiveRatioByWidth(context, 14),
            ),
          ),
          SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              infoModal.show(context: context, isMonth: isMonth);
            },
            child: SvgPicture.asset(
              'assets/icons/info.svg',
              fit: BoxFit.cover,
              width: getResponsiveRatioByWidth(context, 20),
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getResponsiveRatioByWidth(context, 24),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DreamTypeMoodStateRow(),
                SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                DreamTypeMoodStateRow(
                  label: '길몽',
                  veryBad: moodState?.goodDream?.veryBad ?? 0,
                  bad: moodState?.goodDream?.bad ?? 0,
                  ordinary: moodState?.goodDream?.ordinary ?? 0,
                  good: moodState?.goodDream?.good ?? 0,
                  veryGood: moodState?.goodDream?.veryGood ?? 0,
                ),
                SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                DreamTypeMoodStateRow(
                  label: '일상몽',
                  veryBad: moodState?.ordinaryDream?.veryBad ?? 0,
                  bad: moodState?.ordinaryDream?.bad ?? 0,
                  ordinary: moodState?.ordinaryDream?.ordinary ?? 0,
                  good: moodState?.ordinaryDream?.good ?? 0,
                  veryGood: moodState?.ordinaryDream?.veryGood ?? 0,
                ),
                SizedBox(height: getResponsiveRatioByWidth(context, 8)),
                DreamTypeMoodStateRow(
                  label: '악몽',
                  veryBad: moodState?.badDream?.veryBad ?? 0,
                  bad: moodState?.badDream?.bad ?? 0,
                  ordinary: moodState?.badDream?.ordinary ?? 0,
                  good: moodState?.badDream?.good ?? 0,
                  veryGood: moodState?.badDream?.veryGood ?? 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
