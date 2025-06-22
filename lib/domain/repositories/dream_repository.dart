import 'package:mongbi_app/domain/entities/dream.dart';

abstract interface class DreamRepository {
  Future<int> saveDream(Dream dream);

  Future<Dream> analyzeDream(int uid, String dreamContent, int dreamScore);
}
