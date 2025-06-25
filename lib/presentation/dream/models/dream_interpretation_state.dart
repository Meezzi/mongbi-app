class DreamInterpretationState {
  DreamInterpretationState({
    this.dreamId = 0,
    this.dreamSubTitle = '',
    this.dreamInterpretation = '',
    this.dreamKeywords = const [],
    this.psychologicalSubTitle = '',
    this.psychologicalStateInterpretation = '',
    this.psychologicalStateKeywords = const [],
    this.mongbiComment = '',
    this.dreamCategory = '',
    this.interpretationCount = 1,
  });

  final int dreamId;
  final String dreamSubTitle;
  final String dreamInterpretation;
  final List<String> dreamKeywords;
  final String psychologicalSubTitle;
  final String psychologicalStateInterpretation;
  final List<String> psychologicalStateKeywords;
  final String mongbiComment;
  final String dreamCategory;
  final int interpretationCount;
}
