import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/statistics/models/statistics_model.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class StatisticsViewModel extends AsyncNotifier<StatisticsModel?> {
  @override
  Future<StatisticsModel?> build() async {
    // 초기 데이터 로딩
    return fetchMonthStatistics();
  }

  Future<StatisticsModel?> fetchMonthStatistics() async {
    final pickerState = ref.read(pickerViewModelProvider);
    final fetchMonthStatisticsUseCase = ref.read(
      fetchMonthStatisticsUseCaseProvider,
    );

    // 로딩 상태 설정
    state = const AsyncValue.loading();

    try {
      await Future.delayed(Duration(seconds: 3));

      final monthStatistics = await fetchMonthStatisticsUseCase.execute(
        pickerState.focusedMonth,
      );

      final currentState = state.value ?? StatisticsModel();
      final newState = currentState.copyWith(month: monthStatistics);

      // 상태 업데이트
      state = AsyncValue.data(newState);

      // 값도 반환
      return newState;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return null;
    }
  }

  void fetchYearStatistics() {}
}
