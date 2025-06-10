class HistoryDto {
  HistoryDto({
    required this.dreamContent,
    required this.dreamScore,
    required this.dreamKeywords,
    required this.dreamInterpretation,
    required this.psychologicalStateInterpretation,
    required this.psychologicalStateKeywords,
    required this.mongbiComment,
    required this.dreamRegDate,
    required this.dreamIdx,
    required this.userIdx,
    required this.challengeIdx,
  });

  factory HistoryDto.fromJson(Map<String, dynamic> json) => HistoryDto(
    dreamContent: json['DREAM_CONTENT'],
    dreamScore: json['DREAM_SCORE'],
    dreamKeywords: List<String>.from(json['DREAM_KEYWORDS'].map((x) => x)),
    dreamInterpretation: json['DREAM_INTERPRETATION'],
    psychologicalStateInterpretation:
        json['PSYCHOLOGICAL_STATE_INTERPRETATION'],
    psychologicalStateKeywords: List<String>.from(
      json['PSYCHOLOGICALSTATE_KEYWORDS'].map((x) => x),
    ),
    mongbiComment: json['MONGBI_COMMENT'],
    dreamRegDate: DateTime.parse(json['DREAM_REG_DATE']),
    dreamIdx: json['DREAM_IDX'],
    userIdx: json['USER_IDX'],
    challengeIdx: json['CHALLENGE_IDX'],
  );

  final String dreamContent;
  final int dreamScore;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final DateTime dreamRegDate;
  final int dreamIdx;
  final int userIdx;
  final int challengeIdx;

  Map<String, dynamic> toJson() => {
    'DREAM_CONTENT': dreamContent,
    'DREAM_SCORE': dreamScore,
    'DREAM_KEYWORDS': List<dynamic>.from(dreamKeywords.map((x) => x)),
    'DREAM_INTERPRETATION': dreamInterpretation,
    'PSYCHOLOGICAL_STATELNTERPRETATION': psychologicalStateInterpretation,
    'PSYCHOLOGICALSTATE_KEYWORDS': List<dynamic>.from(
      psychologicalStateKeywords.map((x) => x),
    ),
    'MONGBI_COMMENT': mongbiComment,
    'DREAM_REG_DATE': dreamRegDate.toIso8601String(),
    'DREAM_IDX': dreamIdx,
    'USER_IDX': userIdx,
    'CHALLENGE_IDX': challengeIdx,
  };
}
