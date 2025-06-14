import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/setting/models/alarm_setting_state.dart';
import 'package:mongbi_app/presentation/setting/models/bgm_state.dart';
import 'package:mongbi_app/presentation/setting/view_models/alarm_setting_view_model.dart';

final alarmSettingProvider =
    NotifierProvider<AlarmSettingViewModel, AlarmSettingState>(
      () => AlarmSettingViewModel(),
    );

final bgmProvider = NotifierProvider<BgmState, bool>(() => BgmState());
