import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/domain/repositories/history_repository.dart';

class FetchUserDreamsHistoryUseCase {
  FetchUserDreamsHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<List<History>> execute() async {
    return await _repository.feachUserDreamsHistory();
  }
}
