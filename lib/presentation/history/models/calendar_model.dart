import 'package:mongbi_app/domain/entities/history.dart';

class CalendarModel {
  CalendarModel({
    DateTime? focusedDay,
    this.selectedDay,
    List<History>? searchedHistory,
  }) {
    this.focusedDay = focusedDay ?? DateTime.now();
    this.searchedHistory = searchedHistory ?? [];
  }

  // 이 값으로 최소 이전 년도를 정함(ex. 2025-5=2020)
  int minYearValue = 5;
  late DateTime minDateTime = DateTime.utc(
    DateTime.now().year - minYearValue,
    1,
    1,
  );
  DateTime maxDateTime = DateTime.utc(DateTime.now().year, 12, 31);
  DateTime? selectedDay;
  late DateTime focusedDay;
  late List<History> searchedHistory;

  CalendarModel copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    List<History>? searchedHistory,
  }) {
    return CalendarModel(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      searchedHistory: searchedHistory ?? this.searchedHistory,
    );
  }

  @override
  String toString() {
    return '''{
      focusedDay: $focusedDay, 
      selectedDay: $selectedDay,
      searchedHistory: $searchedHistory
    }''';
  }
}
