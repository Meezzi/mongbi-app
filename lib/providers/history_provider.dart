import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_history_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_history_repository.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/domain/repositories/history_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_user_dreams_history_use_case.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/presentation/history/view_models/calendar_view_model.dart';
import 'package:mongbi_app/presentation/history/view_models/history_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _historyDataSourceProvider = Provider<HistoryDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return RemoteHistoryDataSource(dio);
});

final _historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final dataSource = ref.read(_historyDataSourceProvider);
  return RemoteHistoryRepository(dataSource);
});

final fetchUserDreamsHistoryUseCaseProvider = Provider((ref) {
  final repository = ref.read(_historyRepositoryProvider);
  return FetchUserDreamsHistoryUseCase(repository);
});

final calendarViewModelProvider =
    NotifierProvider.autoDispose<CalendarViewModel, CalendarModel>(() {
      return CalendarViewModel();
    });

final historyViewModelProvider =
    AsyncNotifierProvider.autoDispose<HistoryViewModel, List<History>>(() {
      return HistoryViewModel();
    });
