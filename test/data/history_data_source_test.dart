import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/data/data_sources/history_data_source_impl.dart';
import 'package:mongbi_app/data/dtos/history_dto.dart';

class MockDio extends Mock implements Dio {}

void main() {
  // green, refactor
  MockDio? mockDio;
  HistoryDataSource? historyDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    historyDataSourceImpl = HistoryDataSourceImpl(mockDio!);
  });
  test('HistoryDataSource test', () async {
    // red
    // final historyDataSource = HistoryDataSource();
    // final historyDtoList = historyDataSource.fetchAllHistory();
    // expect(historyDtoList, isA<List<HistoryDto>>());

    // json이 이런 형태인 이유는
    // fetchAllHistory 내부에서 ['result']로 값을 받기 때문
    final json = '''
{
  "results": [
    {
      "DREAM_CONTENT": "꿈1",
      "DREAM_SCORE": 1,
      "DREAM_TAG": "꿈1",
      "DREAM_KEYWORDS": [
        "꿈1"
      ],
      "DREAM_INTERPRETATION": "꿈1",
      "PSYCHOLOGICAL_STATELNTERPRETATION": "꿈1",
      "PSYCHOLOGICALSTATE_KEYWORDS": [
        "꿈1"
      ],
      "MONGBI_COMMENT": "꿈1",
      "EMOTION_CATEGORY": "꿈1"
    }
  ]
}
''';

    final map = jsonDecode(json);
    final response = Response<Map<String, dynamic>>(
      data: map,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/dream'),
    );

    when(() {
      return mockDio!.get(any());
    }).thenAnswer((invocation) async {
      return response;
    });

    final hisotoryDtoList = await historyDataSourceImpl!.fetchAllHistory();

    expect(hisotoryDtoList, isA<List<HistoryDto>>());
    expect(hisotoryDtoList.first.dreamContent, '꿈1');
  });
}
