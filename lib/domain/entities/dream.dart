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
}
