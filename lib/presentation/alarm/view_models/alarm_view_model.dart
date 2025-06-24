import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/alarm.dart';
import 'package:mongbi_app/providers/alarm_provider.dart';

class AlarmViewModel extends Notifier<List<Alarm>?> {
  @override
  List<Alarm>? build() {
    fetchAlarms();
    return null;
  }

  Future<void> fetchAlarms() async {
    final fetchAlarmsUseCase = ref.read(fetchAlarmUseCaseProvider);
    final alarmList = await fetchAlarmsUseCase.execute();

    state = alarmList;
  }

  Future<void> updateIsReadStatus(int id) async {
    final updateIsReadStatusUseCase = ref.read(
      updateIsReadStatusUseCaseProvider,
    );
    await updateIsReadStatusUseCase.execute(id);
  }

  void clearAlarmList() {
    state = null;
  }
}
