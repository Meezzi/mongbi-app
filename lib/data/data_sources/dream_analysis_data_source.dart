abstract interface class DreamAnalysisDataSource {
  Future<Map<String, dynamic>> analyzeDream(String dreamContent, int dreamScore);
}
