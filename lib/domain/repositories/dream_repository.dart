import 'package:mongbi_app/domain/entities/dream.dart';

abstract interface class DreamRepository {
  Future<bool> saveDream(Dream dream);

  Future<Dream> analyzeDream(String dreamContent, int dreamScore);
}
