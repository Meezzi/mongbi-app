import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/data/dtos/alarm_dto.dart';
import 'package:mongbi_app/data/repositories/remote_alarm_repository.dart';
import 'package:mongbi_app/domain/entities/alarm.dart';

class MockAlarmDataSource extends Mock implements AlarmDataSource {}

void main() {
  test('AlarmRepository test', () async {
    MockAlarmDataSource mockAlarmDataSource = MockAlarmDataSource();

    when(() {
      return mockAlarmDataSource.fetchAlarms();
    }).thenAnswer((invocation) async {
      return [
        AlarmDto(
          id: 1,
          type: '타입',
          date: DateTime(2025, 11, 11),
          content: '내용',
          isConfirm: false,
        ),
      ];
    });

    final alarmRepository = RemoteAlarmRepository(mockAlarmDataSource);
    final alarmList = await alarmRepository.fetchAlarms();

    expect(alarmList, isA<List<Alarm>>());
    expect(alarmList!.first.type, '타입');
  });
}
