import 'package:mongbi_app/domain/repositories/challenge_repository.dart';

class CompleteChallengeUseCase {
  CompleteChallengeUseCase({required this.repository});

  final ChallengeRepository repository;

  Future<bool> execute({
    required int uid,
    required int challengeId,
    required String challengeStatus,
  }) async {
    return await repository.completeChallenge(
      uid: uid,
      challengeId: challengeId,
      challengeStatus: challengeStatus,
    );
  }
}
