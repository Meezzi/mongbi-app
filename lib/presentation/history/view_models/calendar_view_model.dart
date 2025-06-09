import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Calendar {
  Calendar({DateTime? focusedDay, this.selectedDay, String? dropDownvalue}) {
    this.focusedDay = focusedDay ?? DateTime.now();
    this.dropDownvalue =
        dropDownvalue ?? DateFormat('yyyy년 MM월').format(DateTime.now());
  }

  late DateTime focusedDay;
  DateTime? selectedDay;
  late String dropDownvalue;

  Calendar copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    String? dropDownvalue,
  }) {
    return Calendar(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      dropDownvalue: dropDownvalue ?? this.dropDownvalue,
    );
  }

  @override
  String toString() {
    return '''{
      focusedDay: $focusedDay, 
      selectedDay: $selectedDay,
      dropDownvalue: $dropDownvalue
    }''';
  }
}

class CalendarViewModel extends AutoDisposeNotifier<Calendar> {
  @override
  Calendar build() {
    return Calendar();
  }

  void onChangedCalendar(DateTime date) {
    state = state.copyWith(focusedDay: date);
  }

  void onChangeDropDownValue(dynamic value) {
    state = state.copyWith(dropDownvalue: value);
    print('adfadf');
    print(state.toString());
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    state = state.copyWith(selectedDay: selectedDay, focusedDay: focusedDay);
  }

  void onPageChanged(DateTime focusedDay) {
    state = state.copyWith(focusedDay: focusedDay);
  }
}

final calendarViewModelProvider =
    NotifierProvider.autoDispose<CalendarViewModel, Calendar>(() {
      return CalendarViewModel();
    });
