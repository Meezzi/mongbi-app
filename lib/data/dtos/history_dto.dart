class HistoryDto {
  HistoryDto({
    required this.dreamContent,
    required this.dreamScore,
    required this.dreamTag,
    required this.dreamKeywords,
    required this.dreamInterpretation,
    required this.psychologicalStatelnterpretation,
    required this.psychologicalstateKeywords,
    required this.mongbiComment,
    required this.emotionCategory,
  });

  factory HistoryDto.fromJson(Map<String, dynamic> json) => HistoryDto(
    dreamContent: json['DREAM_CONTENT'],
    dreamScore: json['DREAM_SCORE'],
    dreamTag: json['DREAM_TAG'],
    dreamKeywords: List<String>.from(json['DREAM_KEYWORDS'].map((x) => x)),
    dreamInterpretation: json['DREAM_INTERPRETATION'],
    psychologicalStatelnterpretation: json['PSYCHOLOGICAL_STATELNTERPRETATION'],
    psychologicalstateKeywords: List<String>.from(
      json['PSYCHOLOGICALSTATE_KEYWORDS'].map((x) => x),
    ),
    mongbiComment: json['MONGBI_COMMENT'],
    emotionCategory: json['EMOTION_CATEGORY'],
  );

  final String dreamContent;
  final int dreamScore;
  final String dreamTag;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStatelnterpretation;
  final List<String> psychologicalstateKeywords;
  final String mongbiComment;
  final String emotionCategory;

  Map<String, dynamic> toJson() => {
    'DREAM_CONTENT': dreamContent,
    'DREAM_SCORE': dreamScore,
    'DREAM_TAG': dreamTag,
    'DREAM_KEYWORDS': List<dynamic>.from(dreamKeywords.map((x) => x)),
    'DREAM_INTERPRETATION': dreamInterpretation,
    'PSYCHOLOGICAL_STATELNTERPRETATION': psychologicalStatelnterpretation,
    'PSYCHOLOGICALSTATE_KEYWORDS': List<dynamic>.from(
      psychologicalstateKeywords.map((x) => x),
    ),
    'MONGBI_COMMENT': mongbiComment,
    'EMOTION_CATEGORY': emotionCategory,
  };
}
