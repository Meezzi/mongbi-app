import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/domain/entities/history.dart';

class CalendarModel {
  CalendarModel({
    DateTime? focusedDay,
    this.selectedDay,
    String? dropDownvalue,
    List<History>? searchedHistory,
    DateTime? minDateTime,
    DateTime? maxDateTime,
  }) {
    this.focusedDay = focusedDay ?? DateTime.now();
    this.dropDownvalue =
        dropDownvalue ?? DateFormatter.formatYearMonth(DateTime.now());
    this.searchedHistory = searchedHistory ?? [];
    this.minDateTime =
        minDateTime ?? DateTime.utc(this.focusedDay.year - minYearValue, 1, 1);
    this.maxDateTime =
        maxDateTime ?? DateTime.utc(this.focusedDay.year, 12, 31);
  }

  // 이 값으로 최소 이전 년도를 정함(ex. 2025-5=2020)
  int minYearValue = 5;
  DateTime? selectedDay;
  late DateTime focusedDay;
  late String dropDownvalue;
  late List<History> searchedHistory;
  late DateTime minDateTime;
  late DateTime maxDateTime;

  CalendarModel copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    String? dropDownvalue,
    List<History>? searchedHistory,
  }) {
    return CalendarModel(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      dropDownvalue: dropDownvalue ?? this.dropDownvalue,
      searchedHistory: searchedHistory ?? this.searchedHistory,
    );
  }

  @override
  String toString() {
    return '''{
      focusedDay: $focusedDay, 
      selectedDay: $selectedDay,
      dropDownvalue: $dropDownvalue
      searchedHistory: $searchedHistory
    }''';
  }
}
