abstract interface class ActiveChallengeDataSource {
  Future<int?> fetchActiveChallengeId({required int uid});
}
