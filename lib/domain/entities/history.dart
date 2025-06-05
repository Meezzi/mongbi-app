class History {
  History({
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

  final String dreamContent;
  final int dreamScore;
  final String dreamTag;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStatelnterpretation;
  final List<String> psychologicalstateKeywords;
  final String mongbiComment;
  final String emotionCategory;
}
