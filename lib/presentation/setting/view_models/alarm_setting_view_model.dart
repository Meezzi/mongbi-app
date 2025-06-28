import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/setting/models/alarm_setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmSettingViewModel extends AsyncNotifier<AlarmSettingState> {
  late SharedPreferences _prefs;

  @override
  Future<AlarmSettingState> build() async {
    _prefs = await SharedPreferences.getInstance();

    final isReminder = _prefs.getBool('alarm_isReminder') ?? false;
    final isChallenge = _prefs.getBool('alarm_isChallenge') ?? false;

    return AlarmSettingState(
      isReminder: isReminder,
      isChallenge: isChallenge,
      isAll: isReminder && isChallenge,
      isInitialized: true,
    );
  }

  Future<void> toggleAll() async {
    final prev = state.value!;
    final next = !prev.isAll;

    final nextState = AlarmSettingState(
      isAll: next,
      isReminder: next,
      isChallenge: next,
      isInitialized: true,
    );

    state = AsyncValue.data(nextState);
    _saveState(nextState);

    final notificationService = NotificationService();
    if (next) {
      await notificationService.scheduleDailyReminder(
        const TimeOfDay(hour: 8, minute: 0),
      );
    } else {
      await notificationService.cancelReminderNotification();
    }
  }

  Future<bool> toggleReminder() async {
    final prev = state.value!;
    final next = !prev.isReminder;

    final nextState = prev.copyWith(isReminder: next).recalculateIsAll();

    state = AsyncValue.data(nextState);
    _saveState(nextState);

    final notificationService = NotificationService();
    if (next) {
      await notificationService.scheduleDailyReminder(
        const TimeOfDay(hour: 8, minute: 0),
      );
    } else {
      await notificationService.cancelReminderNotification();
    }

    return next;
  }

  Future<void> toggleChallenge() async {
    final prev = state.value!;
    final nextState =
        prev.copyWith(isChallenge: !prev.isChallenge).recalculateIsAll();

    state = AsyncValue.data(nextState);
    _saveState(nextState);
  }

  void setReminder(bool value) {
    final prev = state.requireValue;

    final newState = prev.copyWith(isReminder: value).recalculateIsAll();
    state = AsyncValue.data(newState);
    _saveState(newState);
  }

  void _saveState(AlarmSettingState s) {
    _prefs.setBool('alarm_isReminder', s.isReminder);
    _prefs.setBool('alarm_isChallenge', s.isChallenge);
  }
}
