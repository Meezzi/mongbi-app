import 'package:mongbi_app/domain/entities/challenge.dart';

class ChallengeState {
  const ChallengeState({
    this.challenges = const [],
    this.selectedChallengeIndex,
    this.isLoading = false,
    this.error,
  });

  final List<Challenge> challenges;
  final int? selectedChallengeIndex;
  final bool isLoading;
  final String? error;

  ChallengeState copyWith({
    List<Challenge>? challenges,
    int? selectedChallengeIndex,
    bool? isLoading,
    String? error,
  }) {
    return ChallengeState(
      challenges: challenges ?? this.challenges,
      selectedChallengeIndex:
          selectedChallengeIndex ?? this.selectedChallengeIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
