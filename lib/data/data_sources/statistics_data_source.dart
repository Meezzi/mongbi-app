import 'package:mongbi_app/data/dtos/statistics_dto.dart';

abstract interface class StatisticsDataSource {
  Future<StatisticsDto?> feachMonthStatistics(DateTime dateTime);
  Future<StatisticsDto?> feachYearStatistics(DateTime dateTime);
}
