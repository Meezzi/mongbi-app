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
              fcmId: e.fcmId!,
              fcmSendFromUserId: e.fcmSendFromUserId!,
              fcmContent: e.fcmContent!,
              fcmType: e.fcmType!,
              fcmSendAt: e.fcmSendAt!,
              fcmIsRead: e.fcmIsRead!,
            ),
          )
          .toList();
    }

    return null;
  }

  @override
  Future<bool> updateIsReadStatus(int id) async {
    return await dataSource.updateIsReadStatus(id);
  }
}
