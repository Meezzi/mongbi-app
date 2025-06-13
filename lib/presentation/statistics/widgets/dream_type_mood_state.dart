import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_type_mood_state_row.dart';
import 'package:mongbi_app/presentation/statistics/widgets/mood_state_info_modal.dart';

class DreamTypeMoodState extends StatelessWidget {
  DreamTypeMoodState({super.key});

  final infoModal = MoodStateInfoModal();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: EdgeInsets.only(bottom: 32),
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
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Text('꿈 유형별 기분 상태', style: Font.title14),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      infoModal.show(context);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/info.svg',
                      fit: BoxFit.cover,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DreamTypeMoodStateRow(),
                    SizedBox(height: 8),
                    DreamTypeMoodStateRow(
                      label: '길몽',
                      veryBad: 0,
                      bad: 12,
                      ordinary: 3,
                      good: 10,
                      veryGood: 6,
                    ),
                    SizedBox(height: 8),
                    DreamTypeMoodStateRow(
                      label: '일상몽',
                      veryBad: 2,
                      bad: 5,
                      ordinary: 9,
                      good: 10,
                      veryGood: 4,
                    ),
                    SizedBox(height: 8),
                    DreamTypeMoodStateRow(
                      label: '악몽',
                      veryBad: 20,
                      bad: 1,
                      ordinary: 6,
                      good: 0,
                      veryGood: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
