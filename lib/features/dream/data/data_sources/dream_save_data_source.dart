import 'package:mongbi_app/features/dream/data/dtos/dream_dto.dart';

abstract interface class DreamSaveDataSource {
  Future<int> saveDream(DreamDto dream);
}
