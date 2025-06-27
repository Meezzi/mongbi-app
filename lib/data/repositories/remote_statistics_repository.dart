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
      final totalDays =
          DateTime(
            afterOneMonth.year,
            afterOneMonth.month,
            afterOneMonth.day - 1,
          ).day;

      return Statistics(
        month: statisticsDto.month,
        totalDays: totalDays,
        frequency: statisticsDto.frequency,
        distribution: statisticsDto.distribution,
        moodState: statisticsDto.moodState,
        keywords: statisticsDto.keywords,
        challengeSuccessRate: statisticsDto.challengeSuccessRate,
      );
    }

    return null;
  }

  @override
  Future<Statistics?> fetchYearStatistics(DateTime dateTime) async {
    final statisticsDto = await dataSource.fetchYearStatistics(dateTime);
    if (statisticsDto != null) {
      final firstDay = DateTime(dateTime.year, 1, 1);
      final lastDay = DateTime(dateTime.year + 1, 1, 1);
      final totalDays = lastDay.difference(firstDay).inDays;

      return Statistics(
        year: statisticsDto.year,
        totalDays: totalDays,
        frequency: statisticsDto.frequency,
        distribution: statisticsDto.distribution,
        moodState: statisticsDto.moodState,
        keywords: statisticsDto.keywords,
        challengeSuccessRate: statisticsDto.challengeSuccessRate,
      );
    }

    return null;
  }
}
