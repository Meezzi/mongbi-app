import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/domain/entities/statistics.dart';
import 'package:mongbi_app/domain/repositories/statistics_repository.dart';

class RemoteStatisticsRepository implements StatisticsRepository {
  RemoteStatisticsRepository(this.dataSource);

  StatisticsDataSource dataSource;

  @override
  Future<Statistics?> fetchMonthStatistics(DateTime dateTime) async {
    final statisticsDto = await dataSource.fetchMonthStatistics(dateTime);
    if (statisticsDto != null) {
      final afterOneMonth = DateTime(dateTime.year, dateTime.month + 1);
      final totlaDays =
          DateTime(
            afterOneMonth.year,
            afterOneMonth.month,
            afterOneMonth.day - 1,
          ).day;

      return Statistics(
        month: statisticsDto.month,
        totalDays: totlaDays,
        frequency: statisticsDto.frequency,
        distribution: statisticsDto.distribution,
        moodState: statisticsDto.moodState,
        keywords: statisticsDto.keywords,
      );
    }

    return null;
  }

  @override
  Future<Statistics?> fetchYearStatistics(DateTime dateTime) {
    // TODO: implement feachYearStatistics
    throw UnimplementedError();
  }
}
