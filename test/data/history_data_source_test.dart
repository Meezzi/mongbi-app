import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_history_data_source.dart';
import 'package:mongbi_app/data/dtos/history_dto.dart';

class MockDio extends Mock implements Dio {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  MockDio? mockDio;
  MockSecureStorageService? mockSecureStorageService;
  HistoryDataSource? historyDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    mockSecureStorageService = MockSecureStorageService();
    historyDataSourceImpl = RemoteHistoryDataSource(
      mockDio!,
      mockSecureStorageService!,
    );
  });
  test('HistoryDataSource test', () async {
    when(
      () => mockSecureStorageService!.getUserIdx(),
    ).thenAnswer((_) async => 1);
    final json = '''
{
  "code": 201,
  "success": true,
  "data": [
    {
      "DREAM_CONTENT": "꿈1",
      "DREAM_SCORE": 1,
      "DREAM_KEYWORDS": [
        "꿈1"
      ],
      "DREAM_INTERPRETATION": "꿈1",
      "PSYCHOLOGICAL_STATE_INTERPRETATION": "꿈1",
      "PSYCHOLOGICALSTATE_KEYWORDS": [
        "꿈1"
      ],
      "MONGBI_COMMENT": "꿈1",
      "DREAM_REG_DATE": "2025-06-20T00:00:00.000Z",
      "DREAM_IDX": 1,
      "USER_IDX": 1,
      "CHALLENGE_IDX": 1,
      "CHALLENGE_DESC": "챌린지 설명",
      "CHALLENGE_TYPE": "챌린지 타입",
      "CHALLENGE_STATUS": "ACTIVE"
    }
  ]
}
''';

    final jsonMap = jsonDecode(json);
    final response = Response(
      data: jsonMap,
      statusCode: 201,
      requestOptions: RequestOptions(path: '/dream'),
    );

    when(() => mockDio!.get(any())).thenAnswer((_) async => response);

    final hisotoryDtoList =
        await historyDataSourceImpl!.feachUserDreamsHistory();

    expect(hisotoryDtoList, isA<List<HistoryDto>>());
    expect(hisotoryDtoList.first.dreamContent, '꿈1');
  });
}
