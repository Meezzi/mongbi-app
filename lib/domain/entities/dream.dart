class Dream {
  Dream({
    this.id,
    required this.createdAt,
    required this.uid,
    required this.challengeId,
    required this.content,
    required this.score,
    required this.dreamKeywords,
    required this.dreamSubTitle,
    required this.dreamInterpretation,
    required this.psychologicalSubTitle,
    required this.psychologicalStateInterpretation,
    required this.psychologicalStateKeywords,
    required this.mongbiComment,
    required this.dreamCategory,
  });

  int? id;
  final DateTime createdAt;
  final int uid;
  final int challengeId;
  final String content;
  final int score;
  final List<String> dreamKeywords;
  final String dreamSubTitle;
  final String dreamInterpretation;
  final String psychologicalSubTitle;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final String dreamCategory;

  Dream copyWith({
    int? id,
    DateTime? createdAt,
    int? uid,
    int? challengeId,
    String? content,
    int? score,
    List<String>? dreamKeywords,
    String? dreamSubTitle,
    String? dreamInterpretation,
    String? psychologicalSubTitle,
    String? psychologicalStateInterpretation,
    List<String>? psychologicalStateKeywords,
    String? mongbiComment,
    String? dreamCategory,
  }) {
    return Dream(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      challengeId: challengeId ?? this.challengeId,
      content: content ?? this.content,
      score: score ?? this.score,
      dreamKeywords: dreamKeywords ?? this.dreamKeywords,
      dreamSubTitle: dreamSubTitle ?? this.dreamSubTitle,
      dreamInterpretation: dreamInterpretation ?? this.dreamInterpretation,
      psychologicalSubTitle:
          psychologicalSubTitle ?? this.psychologicalSubTitle,
      psychologicalStateInterpretation:
          psychologicalStateInterpretation ??
          this.psychologicalStateInterpretation,
      psychologicalStateKeywords:
          psychologicalStateKeywords ?? this.psychologicalStateKeywords,
      mongbiComment: mongbiComment ?? this.mongbiComment,
      dreamCategory: dreamCategory ?? this.dreamCategory,
    );
  }
}
