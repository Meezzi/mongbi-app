import 'package:mongbi_app/core/date_formatter.dart';

class CalendarModel {
  CalendarModel({
    DateTime? focusedDay,
    this.selectedDay,
    String? dropDownvalue,
  }) {
    this.focusedDay = focusedDay ?? DateTime.now();
    this.dropDownvalue =
        dropDownvalue ?? DateFormatter.formatYearMonth(DateTime.now());
  }

  late DateTime focusedDay;
  DateTime? selectedDay;
  late String dropDownvalue;

  CalendarModel copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    String? dropDownvalue,
  }) {
    return CalendarModel(
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
