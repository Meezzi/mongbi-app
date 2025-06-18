import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/domain/repositories/history_repository.dart';

class RemoteHistoryRepository implements HistoryRepository {
  RemoteHistoryRepository(this._dataSource);

  final HistoryDataSource _dataSource;

  @override
  Future<List<History>> feachUserDreamsHistory() async {
    final historyDtoList = await _dataSource.feachUserDreamsHistory();
    return historyDtoList
        .map(
          (e) => History(
            dreamContent: e.dreamContent,
            dreamScore: e.dreamScore,
            dreamKeywords: e.dreamKeywords,
            dreamInterpretation: e.dreamInterpretation,
            psychologicalStateInterpretation:
                e.psychologicalStateInterpretation,
            psychologicalStateKeywords: e.psychologicalStateKeywords,
            mongbiComment: e.mongbiComment,
            dreamRegDate: e.dreamRegDate,
          ),
        )
        .toList();
  }
}
