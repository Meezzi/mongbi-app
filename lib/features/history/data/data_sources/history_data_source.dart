import 'package:mongbi_app/features/history/data/dtos/history_dto.dart';

abstract interface class HistoryDataSource {
  Future<List<HistoryDto>> feachUserDreamsHistory();
}
