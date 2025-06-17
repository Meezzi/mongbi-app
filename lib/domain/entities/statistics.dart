import 'package:mongbi_app/data/dtos/statistics_dto.dart';

class Statistics {
  Statistics({
    this.month,
    this.year,
    this.totalDays,
    required this.frequency,
    required this.distribution,
    required this.moodState,
    required this.keywords,
  });

  final String? month;
  final String? year;
  final int? totalDays;
  final int frequency;
  final DreamScore distribution;
  final MoodState moodState;
  final List<Keyword> keywords;
}
