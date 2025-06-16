import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/statistics/models/picker_model.dart';

class PickerViewModel extends Notifier<PickerModel> {
  @override
  PickerModel build() {
    return PickerModel();
  }

  void onChangedMonth(DateTime date) async {
    print('✅');
    print(date);
    print('✅');

    state = state.copyWith(focusedMonth: date);
  }

  void onChangedYear(DateTime date) async {
    print('✅');
    print(date);
    print('✅');

    state = state.copyWith(focusedYear: date);
  }
}
