import 'package:mongbi_app/domain/repositories/challenge_repository.dart';

class CompleteChallengeUseCase {
  CompleteChallengeUseCase({required this.repository});

  final ChallengeRepository repository;

  Future<bool> completeChallenge({
    required int uid,
    required int dreamId,
    required int challengeId,
  }) async {
    return await repository.completeChallenge(
      uid: uid,
      dreamId: dreamId,
      challengeId: challengeId,
    );
  }
}
