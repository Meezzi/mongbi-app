import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/statistics/models/statistics_model.dart';

class StatisticsViewModel extends AutoDisposeAsyncNotifier<StatisticsModel> {
  @override
  Future<StatisticsModel> build() async {
    return StatisticsModel();
  }

  void onChangedMonth(DateTime date) {
    final statisticsModel = state.value!;
    state = AsyncValue.loading();
    state = AsyncValue.data(statisticsModel.copyWith(focusedDay: date));
  }
}
