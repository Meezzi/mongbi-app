import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/remote_statistics_data_source.dart';
import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio? mockDio;
  StatisticsDataSource? remoteStatisticsDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteStatisticsDataSource = RemoteStatisticsDataSource(mockDio!);
  });
  test('StatisticsDataSource test', () async {
    final json = '''
{
"code": 201,
"success": true,
"data": {
    "MONTH": "2025-06",
    "FREQUENCY": 20,
    "DISTRIBUTION": {
      "1": 10,
      "2": 10,
      "3": 30,
      "4": 0,
      "5": 50
    },
    "MOOD_STATE": {
      "GOOD_DREAM": {
        "1": 0,
        "2": 3,
        "3": 4,
        "4": 2,
        "5": 7
      },
      "ORDINARY_DREAM": {
        "1": 1,
        "2": 3,
        "3": 0,
        "4": 2,
        "5": 7
      },
      "BAD_DREAM": {
        "1": 1,
        "2": 3,
        "3": 4,
        "4": 2,
        "5": 0
      }
    },
    "KEYWORDS": [
      {
        "KEYWORD": "떡볶이",
        "COUNT": 19
      },
      {
        "KEYWORD": "간식",
        "COUNT": 10
      },
      {
        "KEYWORD": "음식",
        "COUNT": 6
      },
      {
        "KEYWORD": "즐거움",
        "COUNT": 4
      },
      {
        "KEYWORD": "고기",
        "COUNT": 3
      }
    ]
  }
}
''';

    final map = jsonDecode(json);
    final response = Response<Map<String, dynamic>>(
      data: map,
      statusCode: 201,
      requestOptions: RequestOptions(path: '/statistics'),
    );

    when(() {
      return mockDio!.get(any());
    }).thenAnswer((invocation) async {
      return response;
    });

    final statisticsDto = await remoteStatisticsDataSource!
        .feachMonthStatistics(DateTime.now());

    expect(statisticsDto, isA<StatisticsDto?>());
    expect(statisticsDto!.frequency, 20);
    expect(statisticsDto.distribution.veryBad, 10);
    expect(statisticsDto.moodState.goodDream!.veryGood, 7);
  });
}
