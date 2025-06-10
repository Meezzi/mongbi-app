class History {
  History({
    required this.dreamContent,
    required this.dreamScore,
    required this.dreamKeywords,
    required this.dreamInterpretation,
    required this.psychologicalStateInterpretation,
    required this.psychologicalStateKeywords,
    required this.mongbiComment,
    required this.dreamRegDate,
  });

  final String dreamContent;
  final int dreamScore;
  final List<String> dreamKeywords;
  final String dreamInterpretation;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final DateTime dreamRegDate;
}
