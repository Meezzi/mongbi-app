String calculateTimeRemaining() {
  final nowUtc = DateTime.now().toUtc();
  final koreaTime = nowUtc.add(Duration(hours: 9));
  
  final endOfDay = DateTime(koreaTime.year, koreaTime.month, koreaTime.day, 23, 59);
  
  final difference = endOfDay.difference(koreaTime);
  final hours = difference.inHours;

  return '$hours시간';
}