import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/domain/entities/alarm.dart';
import 'package:mongbi_app/domain/repositories/alarm_repository.dart';

class RemoteAlarmRepository implements AlarmRepository {
  RemoteAlarmRepository(this.dataSource);

  AlarmDataSource dataSource;

  @override
  Future<List<Alarm>?> fetchAlarms() async {
    final alarmDtoList = await dataSource.fetchAlarms();
    if (alarmDtoList != null) {
      return alarmDtoList
          .map((e) => Alarm(type: e.type, date: e.date, content: e.content))
          .toList();
    }

    return null;
  }
}
