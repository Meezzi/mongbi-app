import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/features/setting/presentation/models/alarm_setting_state.dart';
import 'package:mongbi_app/features/setting/presentation/models/bgm_state.dart';
import 'package:mongbi_app/features/setting/presentation/view_models/alarm_setting_view_model.dart';

final alarmSettingProvider =
    AsyncNotifierProvider<AlarmSettingViewModel, AlarmSettingState>(() => AlarmSettingViewModel());


final bgmProvider = NotifierProvider<BgmState, bool>(() => BgmState());
