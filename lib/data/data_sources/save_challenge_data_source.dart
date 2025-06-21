abstract interface class SaveChallengeDataSource {
  Future<bool> saveChallenge({required int uid, required int challengeId});
}
