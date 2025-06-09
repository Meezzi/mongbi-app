import 'package:mongbi_app/data/data_sources/dream_analysis_data_source.dart';
import 'package:mongbi_app/data/data_sources/dream_save_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

class RemoteDreamRepository implements DreamRepository {
  RemoteDreamRepository(this.dreamSaveDataSource, this.dreamAnalysisDataSource);

  final DreamSaveDataSource dreamSaveDataSource;
  final DreamAnalysisDataSource dreamAnalysisDataSource;

  @override
  Future<bool> saveDream(Dream dream) async {
    final dreamDto = DreamDto.fromEntity(dream);
    return await dreamSaveDataSource.saveDream(dreamDto);
  }

  @override
  Future<String> analyzeDream(String dreamContent, int dreamScore) async {
    return await dreamAnalysisDataSource.analyzeDream(dreamContent, dreamScore);
  }
}
