abstract interface class CompleteChallengeDataSource {
  Future<bool> completeChallenge({
    required int uid,
    required int dreamId,
    required int challengeId,
  });
}
