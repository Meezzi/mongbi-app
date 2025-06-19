import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_alarm_data_source.dart';
import 'package:mongbi_app/data/dtos/alarm_dto.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio? mockDio;
  AlarmDataSource? alarmDataSource;

  setUp(() {
    mockDio = MockDio();
    alarmDataSource = RemoteAlarmDataSource(mockDio!);
  });

  test('AlarmDataSource test', () async {
    final json = '''
{
  "code": 201,
  "success": true,
  "data": [
    {
      "date": "날짜",
      "type": "리마인드",
      "content": "내용"
    }
  ]
}
''';

    final jsonMap = jsonDecode(json);
    final response = Response(
      data: jsonMap,
      statusCode: 201,
      requestOptions: RequestOptions(path: '/alarm'),
    );

    when(() {
      return mockDio!.get(any());
    }).thenAnswer((invocation) async {
      return response;
    });

    final alarmDtoList = await alarmDataSource!.fetchAlarms();

    expect(alarmDtoList, isA<List<AlarmDto>>());
    expect(alarmDtoList!.first.date, '날짜');
  });
}
