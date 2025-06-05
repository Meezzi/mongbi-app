import 'package:mongbi_app/data/dtos/dream_dto.dart';

abstract interface class DreamDataSource {
  Future<bool> saveDream(DreamDto dream);
}
