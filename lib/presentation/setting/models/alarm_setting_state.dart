class AlarmSettingState { 

  AlarmSettingState({
    required this.isAll,
    required this.isReminder,
    required this.isChallenge,
    this.isInitialized = false,
  });
  final bool isAll;
  final bool isReminder;
  final bool isChallenge;
  final bool isInitialized;

  AlarmSettingState copyWith({
    bool? isAll,
    bool? isReminder,
    bool? isChallenge,
    bool? isInitialized,
  }) {
    return AlarmSettingState(
      isAll: isAll ?? this.isAll,
      isReminder: isReminder ?? this.isReminder,
      isChallenge: isChallenge ?? this.isChallenge,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  static AlarmSettingState syncAll(bool value) {
    return AlarmSettingState(
      isAll: value,
      isReminder: value,
      isChallenge: value,
      isInitialized: true, 
    );
  }

  AlarmSettingState recalculateIsAll() {
    final all = isReminder && isChallenge;
    return copyWith(isAll: all);
  }
}
