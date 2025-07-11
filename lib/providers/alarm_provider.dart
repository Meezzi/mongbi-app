import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_alarm_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_alarm_repository.dart';
import 'package:mongbi_app/domain/repositories/alarm_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_alarms_use_case.dart';
import 'package:mongbi_app/domain/use_cases/update_is_read_status_use_case.dart';
import 'package:mongbi_app/presentation/alarm/models/alarm_model.dart';
import 'package:mongbi_app/presentation/alarm/view_models/alarm_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _alarmDataSourceProvider = Provider<AlarmDataSource>((ref) {
  final dio = ref.read(adminDioProvider);
  return RemoteAlarmDataSource(dio);
});

final _alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  final dataSource = ref.read(_alarmDataSourceProvider);
  return RemoteAlarmRepository(dataSource);
});

final fetchAlarmUseCaseProvider = Provider((ref) {
  final repository = ref.read(_alarmRepositoryProvider);
  return FetchAlarmsUseCase(repository);
});

final updateIsReadStatusUseCaseProvider = Provider((ref) {
  final repository = ref.read(_alarmRepositoryProvider);
  return UpdateIsReadStatusUseCase(repository);
});

final alarmViewModelProvider = NotifierProvider<AlarmViewModel, AlarmModel>(() {
  return AlarmViewModel();
});