class Dream {
  Dream({
    this.id,
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

  int? id;
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
}
