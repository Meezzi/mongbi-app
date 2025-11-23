
import 'package:mongbi_app/features/statistics/domain/entities/statistics.dart';

abstract interface class StatisticsRepository {
  Future<Statistics?> fetchMonthStatistics(DateTime dateTime);
  Future<Statistics?> fetchYearStatistics(DateTime dateTime);
}
