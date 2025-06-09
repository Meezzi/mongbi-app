abstract interface class DreamAnalysisDataSource {
  Future<String> analyzeDream(String dreamContent, int dreamScore);
}
