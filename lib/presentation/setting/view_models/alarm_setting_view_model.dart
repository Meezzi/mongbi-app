import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/setting/models/alarm_setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmSettingViewModel extends Notifier<AlarmSettingState> {
  late SharedPreferences _prefs;

  @override
  AlarmSettingState build() {
    _initPrefs();
    return AlarmSettingState(
      isAll: false,
      isReminder: false,
      isChallenge: false,
    );
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    final isReminder = _prefs.getBool('alarm_isReminder') ?? false;
    final isChallenge = _prefs.getBool('alarm_isChallenge') ?? false;

    state =
        AlarmSettingState(
          isReminder: isReminder,
          isChallenge: isChallenge,
          isAll: false,
        ).recalculateIsAll();
  }

  void toggleAll() {
    final next = !state.isAll;
    final nextState = AlarmSettingState(
      isAll: next,
      isReminder: next,
      isChallenge: next,
    );

    state = nextState;
    _saveState(nextState);

    final notificationService = NotificationService();
    if (next) {
      notificationService.scheduleDailyReminder(
        const TimeOfDay(hour: 8, minute: 0),
      );
    } else {
      notificationService.cancelReminderNotification();
    }
  }

  void toggleReminder() async {
    final next = !state.isReminder;
    final nextState = state.copyWith(isReminder: next).recalculateIsAll();

    state = nextState;
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

  void toggleChallenge() {
    final nextState =
        state.copyWith(isChallenge: !state.isChallenge).recalculateIsAll();

    state = nextState;
    _saveState(nextState);
  }

  void _saveState(AlarmSettingState s) {
    _prefs.setBool('alarm_isReminder', s.isReminder);
    _prefs.setBool('alarm_isChallenge', s.isChallenge);
  }
}
