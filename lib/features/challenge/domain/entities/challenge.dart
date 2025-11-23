class Challenge {
  Challenge({
    required this.id,
    required this.content,
    required this.type,
    required this.dreamScore,
    required this.isComplete
  });

  final int id;
  final String content;
  final String type;
  final int dreamScore;
  final bool isComplete;
}
