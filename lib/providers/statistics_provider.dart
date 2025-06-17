import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_statistics_data_source.dart';
import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_statistics_repository.dart';
import 'package:mongbi_app/domain/repositories/statistics_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_month_statistics_use_case.dart';
import 'package:mongbi_app/presentation/statistics/models/picker_model.dart';
import 'package:mongbi_app/presentation/statistics/models/statistics_model.dart';
import 'package:mongbi_app/presentation/statistics/view_models/picker_view_model.dart';
import 'package:mongbi_app/presentation/statistics/view_models/statistics_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _statisticsDataSourceProvider = Provider<StatisticsDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return RemoteStatisticsDataSource(dio);
});

final _statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  final dataSource = ref.read(_statisticsDataSourceProvider);
  return RemoteStatisticsRepository(dataSource);
});

final fetchMonthStatisticsUseCaseProvider = Provider((ref) {
  final repository = ref.read(_statisticsRepositoryProvider);
  return FetchMonthStatisticsUseCase(repository);
});

final pickerViewModelProvider = NotifierProvider<PickerViewModel, PickerModel>(
  () {
    return PickerViewModel();
  },
);

final statisticsViewModelProvider =
    AsyncNotifierProvider<StatisticsViewModel, StatisticsModel?>(() {
      return StatisticsViewModel();
    });
