import 'package:mongbi_app/domain/entities/dream.dart';

class DreamDto {
  DreamDto({
    required this.dreamIdx,
    required this.dreamRegDate,
    required this.userIdx,
    required this.challengeIdx,
    required this.dreamContent,
    required this.dreamScore,
    required this.dreamKeywords,
    required this.dreamInterpretation,
    required this.psychologicalStateInterpretation,
    required this.psychologicalStateKeywords,
    required this.mongbiComment,
    required this.dreamCategory,
  });

  final int dreamIdx;
  final DateTime dreamRegDate;
  final int userIdx;
  final int challengeIdx;
  final String dreamContent;
  final int dreamScore;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final String dreamCategory;

  factory DreamDto.fromJson(Map<String, dynamic> json) {
    return DreamDto(
      dreamIdx: json['DREAM_IDX'],
      dreamRegDate: DateTime.parse(json['DREAM_REG_DATE']),
      userIdx: json['USER_IDX'],
      challengeIdx: json['CHALLENGE_IDX'],
      dreamContent: json['DREAM_CONTENT'],
      dreamScore: json['DREAM_SCORE'],
      dreamKeywords: (json['DREAM_KEYWORDS'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dreamInterpretation: json['DREAM_INTERPRETATION'],
      psychologicalStateInterpretation: json['PSYCHOLOGICAL_STATE_INTERPRETATION'],
      psychologicalStateKeywords: (json['PSYCHOLOGICALSTATE_KEYWORDS'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mongbiComment: json['MONGBI_COMMENT'],
      dreamCategory: json['DREAM_CATEGORY'],
    );
  }

  Map<String, dynamic> toJson() => {
        'DREAM_IDX': dreamIdx,
        'DREAM_REG_DATE': dreamRegDate.toIso8601String(),
        'USER_IDX': userIdx,
        'CHALLENGE_IDX': challengeIdx,
        'DREAM_CONTENT': dreamContent,
        'DREAM_SCORE': dreamScore,
        'DREAM_KEYWORDS': dreamKeywords,
        'DREAM_INTERPRETATION': dreamInterpretation,
        'PSYCHOLOGICAL_STATE_INTERPRETATION': psychologicalStateInterpretation,
        'PSYCHOLOGICALSTATE_KEYWORDS': psychologicalStateKeywords,
        'MONGBI_COMMENT': mongbiComment,
        'DREAM_CATEGORY': dreamCategory,
      };

  factory DreamDto.fromEntity(Dream dream) {
    return DreamDto(
      dreamIdx: dream.id ?? 0,
      dreamRegDate: dream.createdAt,
      userIdx: dream.uid,
      challengeIdx: dream.challengeId,
      dreamContent: dream.content,
      dreamScore: dream.score,
      dreamKeywords: dream.dreamKeywords,
      dreamInterpretation: dream.dreamInterpretation,
      psychologicalStateInterpretation: dream.psychologicalStateInterpretation,
      psychologicalStateKeywords: dream.psychologicalStateKeywords,
      mongbiComment: dream.mongbiComment,
      dreamCategory: dream.dreamCategory,
    );
  }
}
