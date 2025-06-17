import 'package:mongbi_app/data/dtos/statistics_dto.dart';

abstract interface class StatisticsDataSource {
  Future<StatisticsDto?> fetchMonthStatistics(DateTime dateTime);
  Future<StatisticsDto?> fetchYearStatistics(DateTime dateTime);
}
