import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/core/services/secure_storage_service.dart';
import 'package:mongbi_app/features/statistics/data/data_sources/remote_statistics_data_source.dart';
import 'package:mongbi_app/features/statistics/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/features/statistics/data/dtos/statistics_dto.dart';

class MockDio extends Mock implements Dio {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  MockDio? mockDio;
  MockSecureStorageService? mockSecureStorageService;
  StatisticsDataSource? remoteStatisticsDataSource;

  setUp(() {
    mockDio = MockDio();
    mockSecureStorageService = MockSecureStorageService();
    remoteStatisticsDataSource = RemoteStatisticsDataSource(
      mockDio!,
      mockSecureStorageService!,
    );
  });
  test('StatisticsDataSource test', () async {
    when(
      () => mockSecureStorageService!.getUserIdx(),
    ).thenAnswer((_) async => 1);
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
      "길몽": {
        "1": 0,
        "2": 3,
        "3": 4,
        "4": 2,
        "5": 7
      },
      "일상몽": {
        "1": 1,
        "2": 3,
        "3": 0,
        "4": 2,
        "5": 7
      },
      "흉몽": {
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

    final jsonMap = jsonDecode(json);
    final response = Response(
      data: jsonMap,
      statusCode: 201,
      requestOptions: RequestOptions(path: '/statistics'),
    );

    when(() => mockDio!.get(any())).thenAnswer((_) async => response);

    final statisticsDto = await remoteStatisticsDataSource!
        .fetchMonthStatistics(DateTime.now());

    expect(statisticsDto, isA<StatisticsDto?>());
    expect(statisticsDto!.frequency, 20);
    expect(statisticsDto.distribution.veryBad, 10);
    expect(statisticsDto.moodState.goodDream.veryGood, 7);
  });
}
