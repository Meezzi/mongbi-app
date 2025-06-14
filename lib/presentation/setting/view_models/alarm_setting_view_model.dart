import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/setting/models/alarm_setting_state.dart';

class AlarmSettingViewModel extends Notifier<AlarmSettingState> {
  void toggleAll() {
    state = AlarmSettingState.syncAll(!state.isAll);
  }

  void toggleReminder() {
    state = state.copyWith(isReminder: !state.isReminder).recalculateIsAll();
  }

  void toggleChallenge() {
    state = state.copyWith(isChallenge: !state.isChallenge).recalculateIsAll();
  }

  @override
  AlarmSettingState build() {
    // TODO: 초기 알림 설정할 때 했던 값으로 변경
    return AlarmSettingState(
      isAll: false,
      isReminder: false,
      isChallenge: false,
    );
  }
}
