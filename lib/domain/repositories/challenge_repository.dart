import 'package:mongbi_app/domain/entities/challenge.dart';

abstract interface class ChallengeRepository {
  Future<List<Challenge>> fetchChallenge(int dreamScore);

  Future<bool> saveChallenge({
    required int dreamId,
    required int uid,
    required int challengeId,
  });

  Future<Challenge?> fetchActiveChallenge({required int uid});

  Future<bool> completeChallenge({
    required int uid,
    required int challengeId,
    required String challengeStatus,
  });
}
