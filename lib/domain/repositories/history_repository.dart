import 'package:mongbi_app/domain/entities/history.dart';

abstract interface class HistoryRepository {
  Future<List<History>> fetchAllHistory();
}
