import 'package:mongbi_app/data/dtos/dream_dto.dart';

abstract interface class DreamSaveDataSource {
  Future<int> saveDream(DreamDto dream);
}
