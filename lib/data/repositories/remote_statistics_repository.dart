import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/domain/entities/statistics.dart';
import 'package:mongbi_app/domain/repositories/statistics_repository.dart';

class RemoteStatisticsRepository implements StatisticsRepository {
  RemoteStatisticsRepository(this.dataSource);

  StatisticsDataSource dataSource;

  @override
  Future<Statistics?> feachMonthStatistics(DateTime dateTime) async {
    final statisticsDto = await dataSource.feachMonthStatistics(dateTime);
    if (statisticsDto != null) {
      return Statistics(
        month: statisticsDto.month,
        frequency: statisticsDto.frequency,
        distribution: statisticsDto.distribution,
        moodState: statisticsDto.moodState,
        keywords: statisticsDto.keywords,
      );
    }

    return null;
  }

  @override
  Future<Statistics?> feachYearStatistics(DateTime dateTime) {
    // TODO: implement feachYearStatistics
    throw UnimplementedError();
  }
}
