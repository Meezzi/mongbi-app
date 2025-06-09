import 'package:mongbi_app/data/data_sources/dream_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

class RemoteDreamRepository implements DreamRepository {
  RemoteDreamRepository(this.dreamDataSource);

  final DreamDataSource dreamDataSource;

  @override
  Future<bool> saveDream(Dream dream) async {
    final dreamDto = DreamDto.fromEntity(dream);
    return await dreamDataSource.saveDream(dreamDto);
  }
}
