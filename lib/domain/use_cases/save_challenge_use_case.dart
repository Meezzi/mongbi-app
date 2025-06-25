import 'package:mongbi_app/domain/repositories/challenge_repository.dart';

class SaveChallengeUseCase {
  SaveChallengeUseCase({required this.repository});

  final ChallengeRepository repository;

  Future<bool> saveChallenge({
    required int dreamId,
    required int uid,
    required int challengeId,
  }) async {
    return await repository.saveChallenge(
      dreamId: dreamId,
      uid: uid,
      challengeId: challengeId,
    );
  }
}
