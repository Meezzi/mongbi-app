import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/statistics/widgets/dream_mood_distribution_percent.dart';

class DreamMoodDistribution extends StatelessWidget {
  const DreamMoodDistribution({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 16,
              ),
              child: Text('꿈을 꾼 후의 기분 분포도', style: Font.title14),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(child: Container(height: 100, color: Colors.blue)),
                    SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 21),
                      child: Column(
                        children: [
                          DreamMoodDistributionPercent(
                            type: 'very_good',
                            percent: 30,
                          ),
                          SizedBox(height: 8),
                          DreamMoodDistributionPercent(
                            type: 'good',
                            percent: 30,
                          ),
                          SizedBox(height: 8),
                          DreamMoodDistributionPercent(
                            type: 'ordinary',
                            percent: 30,
                          ),
                          SizedBox(height: 8),
                          DreamMoodDistributionPercent(
                            type: 'bad',
                            percent: 30,
                          ),
                          SizedBox(height: 8),
                          DreamMoodDistributionPercent(
                            type: 'very_bad',
                            percent: 40,
                          ),
                        ],
                      ),
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
