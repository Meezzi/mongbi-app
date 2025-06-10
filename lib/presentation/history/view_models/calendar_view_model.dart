import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class CalendarViewModel extends AutoDisposeNotifier<CalendarModel> {
  @override
  CalendarModel build() {
    return CalendarModel();
  }

  void onChangedCalendar(DateTime date) {
    state = state.copyWith(focusedDay: date);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final historyVm = ref.read(historyViewModelProvider.notifier);
    final searchedHistory = historyVm.searchDateTime(selectedDay);

    state = state.copyWith(
      selectedDay: selectedDay,
      focusedDay: focusedDay,
      searchedHistory: searchedHistory,
    );
  }

  void onPageChanged(DateTime focusedDay) {
    state = state.copyWith(focusedDay: focusedDay);
  }
}
