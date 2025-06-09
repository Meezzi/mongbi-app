class History {
  History({
    required this.dreamContent,
    required this.dreamScore,
    required this.dreamTag,
    required this.dreamKeywords,
    required this.dreamInterpretation,
    required this.psychologicalStateInterpretation,
    required this.psychologicalStateKeywords,
    required this.mongbiComment,
    required this.emotionCategory,
    required this.dreamRegDate,
  });

  final String dreamContent;
  final int dreamScore;
  final String dreamTag;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final String emotionCategory;
  final String dreamRegDate;
}
