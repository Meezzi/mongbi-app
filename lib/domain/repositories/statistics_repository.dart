import 'package:mongbi_app/domain/entities/statistics.dart';

abstract interface class StatisticsRepository {
  Future<Statistics?> feachMonthStatistics(DateTime dateTime);
  Future<Statistics?> feachYearStatistics(DateTime dateTime);
}
