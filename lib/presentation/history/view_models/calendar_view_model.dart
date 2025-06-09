import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/history/models/calendar_model.dart';

class CalendarViewModel extends AutoDisposeNotifier<CalendarModel> {
  @override
  CalendarModel build() {
    return CalendarModel();
  }

  void onChangedCalendar(DateTime date) {
    state = state.copyWith(focusedDay: date);
  }

  void onChangeDropDownValue(dynamic value) {
    state = state.copyWith(dropDownvalue: value);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    state = state.copyWith(selectedDay: selectedDay, focusedDay: focusedDay);
  }

  void onPageChanged(DateTime focusedDay) {
    state = state.copyWith(focusedDay: focusedDay);
  }
}

final calendarViewModelProvider =
    NotifierProvider.autoDispose<CalendarViewModel, CalendarModel>(() {
      return CalendarViewModel();
    });
