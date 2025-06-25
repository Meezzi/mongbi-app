String calculateTimeRemaining() {
  final koreaTime = DateTime.now();
  final endOfDay = DateTime(
    koreaTime.year,
    koreaTime.month,
    koreaTime.day,
    23,
    59,
    59,
  );
  final difference = endOfDay.difference(koreaTime);
  final hours = difference.inHours;
  final minutes = difference.inMinutes;
  if (hours >= 1) {
    return '$hours시간';
  } else {
    return '$minutes분';
  }
}
