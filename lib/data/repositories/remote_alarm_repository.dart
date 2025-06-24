import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/domain/entities/alarm.dart';
import 'package:mongbi_app/domain/repositories/alarm_repository.dart';

class RemoteAlarmRepository implements AlarmRepository {
  const RemoteAlarmRepository(this.dataSource);

  final AlarmDataSource dataSource;

  @override
  Future<List<Alarm>?> fetchAlarms() async {
    final alarmDtoList = await dataSource.fetchAlarms();
    if (alarmDtoList != null) {
      return alarmDtoList
          .map(
            (e) => Alarm(
              id: e.id,
              type: e.type,
              date: e.date,
              content: e.content,
              isConfirm: e.isConfirm,
            ),
          )
          .toList();
    }

    return null;
  }

  @override
  Future<bool> updateConfirmStatus(int id) async {
    return await dataSource.updateConfirmStatus(id);
  }
}
