import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/features/statistics/data/data_sources/remote_statistics_data_source.dart';
import 'package:mongbi_app/features/statistics/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/features/statistics/data/repositories/remote_statistics_repository.dart';
import 'package:mongbi_app/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:mongbi_app/features/statistics/domain/use_cases/fetch_month_statistics_use_case.dart';
import 'package:mongbi_app/features/statistics/domain/use_cases/fetch_year_statistics_use_case.dart';
import 'package:mongbi_app/features/statistics/presentation/models/picker_model.dart';
import 'package:mongbi_app/features/statistics/presentation/models/statistics_model.dart';
import 'package:mongbi_app/features/statistics/presentation/view_models/picker_view_model.dart';
import 'package:mongbi_app/features/statistics/presentation/view_models/statistics_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _statisticsDataSourceProvider = Provider<StatisticsDataSource>((ref) {
  final dio = ref.read(dioProvider);
  final secureStorageService = ref.read(secureStorageServiceProvider);
  return RemoteStatisticsDataSource(dio, secureStorageService);
});

final _statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  final dataSource = ref.read(_statisticsDataSourceProvider);
  return RemoteStatisticsRepository(dataSource);
});

final fetchMonthStatisticsUseCaseProvider = Provider((ref) {
  final repository = ref.read(_statisticsRepositoryProvider);
  return FetchMonthStatisticsUseCase(repository);
});

final fetchYearStatisticsUseCaseProvider = Provider((ref) {
  final repository = ref.read(_statisticsRepositoryProvider);
  return FetchYearStatisticsUseCase(repository);
});

final pickerViewModelProvider = NotifierProvider<PickerViewModel, PickerModel>(
  () {
    return PickerViewModel();
  },
);

final statisticsViewModelProvider =
    AsyncNotifierProvider.autoDispose<StatisticsViewModel, StatisticsModel?>(
      () {
        return StatisticsViewModel();
      },
    );

final snackBarStatusProvider = StateProvider<bool>((ref) {
  return false;
});

final tabBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});
