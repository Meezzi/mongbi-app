import 'package:mongbi_app/domain/entities/challenge.dart';

abstract interface class ChallengeRepository {
  Future<List<Challenge>> fetchChallenge(int dreamScore);

  Future<bool> saveChallenge({
    required int dreamId,
    required int uid,
    required int challengeId,
  });

  Future<bool> completeChallenge({
    required int uid,
    required int dreamId,
    required int challengeId,
  });
}
