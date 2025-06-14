class AlarmSettingState {
  AlarmSettingState({
    required this.isAll,
    required this.isReminder,
    required this.isChallenge,
  });

  final bool isAll;
  final bool isReminder;
  final bool isChallenge;

  AlarmSettingState copyWith({
    bool? isAll,
    bool? isReminder,
    bool? isChallenge,
  }) {
    return AlarmSettingState(
      isAll: isAll ?? this.isAll,
      isReminder: isReminder ?? this.isReminder,
      isChallenge: isChallenge ?? this.isChallenge,
    );
  }

  static AlarmSettingState syncAll(bool value) {
    return AlarmSettingState(
      isAll: value,
      isReminder: value,
      isChallenge: value,
    );
  }

  AlarmSettingState recalculateIsAll() {
    final all = isReminder && isChallenge;
    return copyWith(isAll: all);
  }
}
