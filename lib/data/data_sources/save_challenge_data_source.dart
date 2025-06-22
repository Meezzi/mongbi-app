abstract interface class SaveChallengeDataSource {
  Future<bool> saveChallenge({
    required int dreamId,
    required int uid,
    required int challengeId,
  });
}
