class StatisticsDto {
  StatisticsDto({
    this.month,
    this.year,
    required this.frequency,
    required this.distribution,
    required this.moodState,
    required this.keywords,
  });

  final String? month;
  final String? year;
  final int frequency;
  final DreamScore distribution;
  final MoodState moodState;
  final List<Keyword> keywords;

  factory StatisticsDto.fromJson(Map<String, dynamic> json) => StatisticsDto(
    month: json['MONTH'],
    year: json['YEAR'],
    frequency: json['FREQUENCY'],
    distribution: DreamScore.fromJson(json['DISTRIBUTION']),
    moodState: MoodState.fromJson(json['MOOD_STATE']),
    keywords: List<Keyword>.from(
      json['KEYWORDS']!.map((x) => Keyword.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    'MONTH': month,
    'YEAR': year,
    'FREQUENCY': frequency,
    'DISTRIBUTION': distribution.toJson(),
    'MOOD_STATE': moodState.toJson(),
    'KEYWORDS': List<dynamic>.from(keywords.map((x) => x.toJson())),
  };
}

class Keyword {
  final String? keyword;
  final int? count;

  Keyword({this.keyword, this.count});

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      Keyword(keyword: json['KEYWORD'], count: json['COUNT']);

  Map<String, dynamic> toJson() => {'KEYWORD': keyword, 'COUNT': count};
}

class MoodState {
  final DreamScore? goodDream;
  final DreamScore? ordinaryDream;
  final DreamScore? badDream;

  MoodState({this.goodDream, this.ordinaryDream, this.badDream});

  factory MoodState.fromJson(Map<String, dynamic> json) => MoodState(
    goodDream: DreamScore.fromJson(json['GOOD_DREAM']),
    ordinaryDream: DreamScore.fromJson(json['ORDINARY_DREAM']),
    badDream: DreamScore.fromJson(json['BAD_DREAM']),
  );

  Map<String, dynamic> toJson() => {
    'GOOD_DREAM': goodDream!.toJson(),
    'ORDINARY_DREAM': ordinaryDream!.toJson(),
    'BAD_DREAM': badDream!.toJson(),
  };
}

class DreamScore {
  final int veryBad;
  final int bad;
  final int ordinary;
  final int good;
  final int veryGood;

  DreamScore({
    required this.veryBad,
    required this.bad,
    required this.ordinary,
    required this.good,
    required this.veryGood,
  });

  factory DreamScore.fromJson(Map<String, dynamic> json) => DreamScore(
    veryBad: json['VERY_BAD'],
    bad: json['BAD'],
    ordinary: json['ORDINARY'],
    good: json['GOOD'],
    veryGood: json['VERY_GOOD'],
  );

  Map<String, dynamic> toJson() => {
    '1': veryBad,
    '2': bad,
    '3': ordinary,
    '4': good,
    '5': veryGood,
  };
}
