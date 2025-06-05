class DreamDto {
  DreamDto({
    required this.id,
    required this.createdAt,
    required this.uid,
    required this.challengeId,
    required this.content,
    required this.score,
    required this.dreamKeywords,
    required this.dreamInterpretation,
    required this.psychologicalStateInterpretation,
    required this.psychologicalStateKeywords,
    required this.mongbiComment,
    required this.emotionCategory,
  });

  final int id;
  final DateTime createdAt;
  final int uid;
  final int challengeId;
  final String content;
  final int score;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final String emotionCategory;

  DreamDto.fromJson(Map<String, dynamic> json)
    : id = json['DREAM_IDX'],
      createdAt = json['DREAM_REG_DATE'],
      uid = json['USER_IDX'],
      challengeId = json['CHALLENGE_ID'],
      content = json['DREAM_CONTENT'],
      score = json['DREAM_SCORE'],
      dreamKeywords =
          (json['DREAM_KEYWORDS'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      dreamInterpretation = json['DREAM_INTERPRETATION'],
      psychologicalStateInterpretation =
          json['PSYCHOLOGICAL_STATELNTERPRETATION'],
      psychologicalStateKeywords =
          (json['PSYCHOLOGICALSTATE_KEYWORDS'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      mongbiComment = json['MONGBI_COMMENT'],
      emotionCategory = json['EMOTION_CATEGORY'];

  Map<String, dynamic> toJson() => {
    'DREAM_IDX': id,
    'DREAM_REG_DATE': createdAt,
    'USER_IDX': uid,
    'CHALLENGE_ID': challengeId,
    'DREAM_CONTENT': content,
    'DREAM_SCORE': score,
    'DREAM_KEYWORDS': dreamKeywords,
    'DREAM_INTERPRETATION': dreamInterpretation,
    'PSYCHOLOGICAL_STATELNTERPRETATION': psychologicalStateInterpretation,
    'PSYCHOLOGICALSTATE_KEYWORDS': psychologicalStateKeywords,
    'MONGBI_COMMENT': mongbiComment,
    'EMOTION_CATEGORY': emotionCategory,
  };
}
