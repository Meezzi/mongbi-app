import 'package:mongbi_app/features/history/domain/entities/history.dart';

abstract interface class HistoryRepository {
  Future<List<History>> feachUserDreamsHistory();
}
