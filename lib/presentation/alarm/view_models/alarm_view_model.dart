import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/features/alarm/providers/alarm_provider.dart';
import 'package:mongbi_app/presentation/alarm/models/alarm_model.dart';

class AlarmViewModel extends Notifier<AlarmModel> {
  @override
  AlarmModel build() {
    fetchAlarms();
    return AlarmModel();
  }

  Future<void> fetchAlarms() async {
    final fetchAlarmsUseCase = ref.read(fetchAlarmUseCaseProvider);
    final alarmList = await fetchAlarmsUseCase.execute();

    state = state.copyWith(alarmList: alarmList);
  }

  Future<void> updateIsReadStatus(int id) async {
    final updateIsReadStatusUseCase = ref.read(
      updateIsReadStatusUseCaseProvider,
    );

    if (state.alarmList != null) {
      final newAlarmList =
          state.alarmList?.map((e) {
            if (e.fcmId == id) {
              return e.copyWith(fcmIsRead: true);
            }

            return e;
          }).toList();

      state = state.copyWith(alarmList: newAlarmList);

      await updateIsReadStatusUseCase.execute(id);
    }
  }

  void clearAlarmList() {
    state = state.copyWith(alarmList: [], isClear: true);
  }

  void setClear() {
    state = state.copyWith(isClear: false);
  }

  void filterAlarmList(FilterType type) {
    state = state.copyWith(filterType: type);
  }
}
