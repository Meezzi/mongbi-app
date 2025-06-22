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
  Future<int> saveDream(Dream dream) async {
    final dreamDto = DreamDto.fromEntity(dream);
    return await dreamSaveDataSource.saveDream(dreamDto);
  }

  @override
  Future<Dream> analyzeDream(int uid, String dreamContent, int dreamScore) async {
    final responseMap = await dreamAnalysisDataSource.analyzeDream(
      dreamContent,
      dreamScore,
    );
    // JSON 형태를 Dream으로 변경
    final dream = Dream(
      id: null, // TODO: 저장한 후, Dream Id로 저장
      createdAt: DateTime.now(),
      uid: uid,
      challengeId: 0, // TODO: 사용자가 선택한 챌린지 id로 변경
      content: dreamContent,
      score: dreamScore,
      dreamKeywords:
          (responseMap['dreamKeywords'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      dreamSubTitle: responseMap['dreamSubTitle'] as String,
      dreamInterpretation: responseMap['dreamInterpretation'] as String,
      psychologicalSubTitle: responseMap['psychologicalSubTitle'] as String,
      psychologicalStateInterpretation:
          responseMap['psychologicalStateInterpretation'] as String,
      psychologicalStateKeywords:
          (responseMap['psychologicalKeywords'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      mongbiComment: responseMap['mongbiComment'] as String,
      dreamCategory: responseMap['dreamCategory'] as String,
    );
    return dream;
  }
}
