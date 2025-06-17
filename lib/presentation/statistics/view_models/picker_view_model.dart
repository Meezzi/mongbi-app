import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/statistics/models/picker_model.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class PickerViewModel extends Notifier<PickerModel> {
  @override
  PickerModel build() {
    return PickerModel();
  }

  void onChangedMonth(DateTime date) async {
    state = state.copyWith(focusedMonth: date);
    await ref.read(statisticsViewModelProvider.notifier).fetchMonthStatistics();
  }

  void onChangedYear(DateTime date) async {
    state = state.copyWith(focusedYear: date);
  }
}
