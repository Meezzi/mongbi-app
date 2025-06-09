import 'package:intl/intl.dart';

class DateFormatter {
  static String formatYearMonth(DateTime date) {
    return DateFormat('yyyy년 MM월').format(date);
  }
}
