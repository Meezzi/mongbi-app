abstract interface class DreamCheckDataSource {
  Future<bool> canWriteDreamToday({required int uid});
}
