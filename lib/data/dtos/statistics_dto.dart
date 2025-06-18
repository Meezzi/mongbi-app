class StatisticsDto {
  StatisticsDto({
    this.month,
    this.year,
    this.frequency = 0,
    DreamScore? distribution,
    MoodState? moodState,
    List<Keyword>? keywords,
  }) : distribution = distribution ?? DreamScore(),
       moodState = moodState ?? MoodState(),
       keywords = keywords ?? [];

  final String? month;
  final String? year;
  final int frequency;
  final DreamScore distribution;
  final MoodState moodState;
  final List<Keyword> keywords;

  factory StatisticsDto.fromJson(Map<String, dynamic>? json) => StatisticsDto(
    month: json?['MONTH'],
    year: json?['YEAR'],
    frequency: json?['FREQUENCY'] ?? 0,
    distribution: DreamScore.fromJson(json?['DISTRIBUTION']),
    moodState: MoodState.fromJson(json?['MOOD_STATE']),
    keywords:
        (json?['KEYWORDS'] as List?)
            ?.map((x) => Keyword.fromJson(x as Map<String, dynamic>?))
            .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'MONTH': month,
    'YEAR': year,
    'FREQUENCY': frequency,
    'DISTRIBUTION': distribution.toJson(),
    'MOOD_STATE': moodState.toJson(),
    'KEYWORDS': keywords.map((x) => x.toJson()).toList(),
  };
}

class Keyword {
  Keyword({this.keyword = '', this.count = 0});

  final String keyword;
  final int count;

  factory Keyword.fromJson(Map<String, dynamic>? json) =>
      Keyword(keyword: json?['KEYWORD'] ?? '', count: json?['COUNT'] ?? 0);

  Map<String, dynamic> toJson() => {'KEYWORD': keyword, 'COUNT': count};
}

class MoodState {
  MoodState({
    DreamScore? goodDream,
    DreamScore? ordinaryDream,
    DreamScore? badDream,
  }) : goodDream = goodDream ?? DreamScore(),
       ordinaryDream = ordinaryDream ?? DreamScore(),
       badDream = badDream ?? DreamScore();

  final DreamScore goodDream;
  final DreamScore ordinaryDream;
  final DreamScore badDream;

  factory MoodState.fromJson(Map<String, dynamic>? json) => MoodState(
    goodDream: DreamScore.fromJson(json?['길몽']),
    ordinaryDream: DreamScore.fromJson(json?['일상몽']),
    badDream: DreamScore.fromJson(json?['흉몽']),
  );

  Map<String, dynamic> toJson() => {
    '길몽': goodDream.toJson(),
    '일상몽': ordinaryDream.toJson(),
    '흉몽': badDream.toJson(),
  };
}

class DreamScore {
  DreamScore({
    this.veryBad = 0,
    this.bad = 0,
    this.ordinary = 0,
    this.good = 0,
    this.veryGood = 0,
  });

  final int veryBad;
  final int bad;
  final int ordinary;
  final int good;
  final int veryGood;

  factory DreamScore.fromJson(Map<String, dynamic>? json) => DreamScore(
    veryBad: json?['VERY_BAD'] ?? 0,
    bad: json?['BAD'] ?? 0,
    ordinary: json?['ORDINARY'] ?? 0,
    good: json?['GOOD'] ?? 0,
    veryGood: json?['VERY_GOOD'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    '1': veryBad,
    '2': bad,
    '3': ordinary,
    '4': good,
    '5': veryGood,
  };
}
