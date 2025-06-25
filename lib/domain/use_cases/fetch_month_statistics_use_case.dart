import 'package:mongbi_app/domain/entities/statistics.dart';
import 'package:mongbi_app/domain/repositories/statistics_repository.dart';

class FetchMonthStatisticsUseCase {
  FetchMonthStatisticsUseCase(this.repository);

  StatisticsRepository repository;

  Future<Statistics?> execute(DateTime dateTime) async {
    return await repository.fetchMonthStatistics(dateTime);
  }
}
