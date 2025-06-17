import 'package:mongbi_app/domain/entities/statistics.dart';

abstract interface class StatisticsRepository {
  Future<Statistics?> fetchMonthStatistics(DateTime dateTime);
  Future<Statistics?> fetchYearStatistics(DateTime dateTime);
}
