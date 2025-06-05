import 'package:mongbi_app/data/dtos/history_dto.dart';

abstract interface class HistoryDataSource {
  Future<List<HistoryDto>> fetchAllHistory();
}
