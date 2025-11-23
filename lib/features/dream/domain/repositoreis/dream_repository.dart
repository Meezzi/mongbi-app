import 'package:mongbi_app/features/dream/domain/entity/dream.dart';

abstract interface class DreamRepository {
  Future<int> saveDream(Dream dream);

  Future<Dream> analyzeDream(int uid, String dreamContent, int dreamScore);

  Future<bool> canWriteDreamToday(int uid);
}
