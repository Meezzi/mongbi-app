import 'package:intl/intl.dart';

class DateFormatter {
  static String formatYearMonth(DateTime date) {
    return DateFormat('yyyy년 MM월').format(date);
  }

  static String formatYearMonthDayWeek(DateTime date) {
    return DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR').format(date);
  }

  static String formatMonth(DateTime date) {
    return DateFormat('M월', 'ko_KR').format(date);
  }

  static String formatYear(DateTime date) {
    return DateFormat('yyyy년', 'ko_KR').format(date);
  }
}
