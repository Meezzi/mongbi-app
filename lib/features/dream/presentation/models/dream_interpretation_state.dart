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

  DreamInterpretationState copyWith({
    int? dreamId,
    String? dreamSubTitle,
    String? dreamInterpretation,
    List<String>? dreamKeywords,
    String? psychologicalSubTitle,
    String? psychologicalStateInterpretation,
    List<String>? psychologicalStateKeywords,
    String? mongbiComment,
    String? dreamCategory,
  }) {
    return DreamInterpretationState(
      dreamId: dreamId ?? this.dreamId,
      dreamSubTitle: dreamSubTitle ?? this.dreamSubTitle,
      dreamInterpretation: dreamInterpretation ?? this.dreamInterpretation,
      dreamKeywords: dreamKeywords ?? this.dreamKeywords,
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
