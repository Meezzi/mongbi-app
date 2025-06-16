import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/data/repositories/remote_statistics_repository.dart';
import 'package:mongbi_app/domain/entities/statistics.dart';

class MockRemoteDataSource extends Mock implements StatisticsDataSource {}

void main() {
  test('StatisticsRepository test', () async {
    final mockRemoteDataSource = MockRemoteDataSource();

    when(() {
      return mockRemoteDataSource.feachMonthStatistics(any());
    }).thenAnswer((invocation) async {
      return StatisticsDto(
        month: '2025-06',
        frequency: 15,
        distribution: DreamScore(
          veryBad: 1,
          bad: 3,
          ordinary: 4,
          good: 7,
          veryGood: 9,
        ),
        moodState: MoodState(
          goodDream: DreamScore(
            veryBad: 2,
            bad: 20,
            ordinary: 200,
            good: 2000,
            veryGood: 20000,
          ),
          ordinaryDream: DreamScore(
            veryBad: 3,
            bad: 30,
            ordinary: 300,
            good: 3000,
            veryGood: 30000,
          ),
          badDream: DreamScore(
            veryBad: 4,
            bad: 40,
            ordinary: 400,
            good: 4000,
            veryGood: 40000,
          ),
        ),
        keywords: [
          Keyword(keyword: '안녕', count: 10),
          Keyword(keyword: '또안녕', count: 9),
          Keyword(keyword: '감사', count: 7),
          Keyword(keyword: '또감사', count: 3),
          Keyword(keyword: '즐거움', count: 2),
        ],
      );
    });

    final remoteStatisticsRepository = RemoteStatisticsRepository(
      mockRemoteDataSource,
    );

    final statisticsEntity = await remoteStatisticsRepository
        .feachMonthStatistics(DateTime.now());

    expect(statisticsEntity, isA<Statistics?>());
    expect(statisticsEntity!.frequency, 15);
    expect(statisticsEntity.keywords.first.keyword, '안녕');
  });
}
