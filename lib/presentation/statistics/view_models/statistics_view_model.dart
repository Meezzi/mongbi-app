import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/statistics/models/statistics_model.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class StatisticsViewModel extends AutoDisposeAsyncNotifier<StatisticsModel?> {
  bool _isMounted = true;

  @override
  Future<StatisticsModel?> build() async {
    final tabBarIndex = ref.read(tabBarIndexProvider);

    // dispose시 콜백함수 호출
    ref.onDispose(() {
      _isMounted = false;
    });

    if (tabBarIndex == 0) {
      return _fetchMonthStatistics();
    } else if (tabBarIndex == 1) {
      return _fetchYearStatistics();
    }

    return StatisticsModel();
  }

  /// build 메서드 전용
  Future<StatisticsModel?> _fetchMonthStatistics() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final pickerState = ref.read(pickerViewModelProvider);
      final useCase = ref.read(fetchMonthStatisticsUseCaseProvider);
      final monthStats = await useCase.execute(pickerState.focusedMonth);

      if (monthStats == null) throw Exception('앗! 통신 오류가 발생했다몽!');

      return StatisticsModel(month: monthStats);
    } catch (_) {
      return StatisticsModel();
    }
  }

  /// build 메서드 전용
  Future<StatisticsModel?> _fetchYearStatistics() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final pickerState = ref.read(pickerViewModelProvider);
      final useCase = ref.read(fetchYearStatisticsUseCaseProvider);
      final yearStats = await useCase.execute(pickerState.focusedYear);

      if (yearStats == null) throw Exception('앗! 통신 오류가 발생했다몽!');

      return StatisticsModel(year: yearStats);
    } catch (_) {
      return StatisticsModel();
    }
  }

  /// 탭바, 월 선택자 등 수동 호출용
  Future<void> fetchMonthStatistics() async {
    state = const AsyncLoading();
    final result = await _fetchMonthStatistics();

    if (_isMounted) {
      state = AsyncData(result);
    }
  }

  /// 탭바, 년 선택자 등 수동 호출용
  Future<void> fetchYearStatistics() async {
    state = const AsyncLoading();
    final result = await _fetchYearStatistics();

    if (_isMounted) {
      state = AsyncData(result);
    }
  }
}
