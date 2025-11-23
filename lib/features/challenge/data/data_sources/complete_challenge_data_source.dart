abstract interface class CompleteChallengeDataSource {
  Future<bool> completeChallenge({
    required int uid,
    required int challengeId,
    required String challengeStatus,
  });
}
