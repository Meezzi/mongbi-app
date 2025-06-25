import 'dart:async';
import 'dart:ui';

class DeadlineManager {
  Timer? _timer;
  bool _isDeadlinePassed = false;
  VoidCallback? _onDeadlineReached;

  static const int _deadlineHour = 23;
  static const int _deadlineMinute = 59;
  static const int _deadlineSecond = 59;

  bool get isDeadlinePassed => _isDeadlinePassed;

  DateTime get _koreaTime => DateTime.now().toUtc().add(Duration(hours: 9));

  DateTime get _endOfDay {
    final koreaTime = _koreaTime;
    return DateTime(
      koreaTime.year,
      koreaTime.month,
      koreaTime.day,
      _deadlineHour,
      _deadlineMinute,
      _deadlineSecond,
    );
  }

  void checkInitialDeadlineStatus() {
    final koreaTime = _koreaTime;
    final endOfDay = _endOfDay;

    _isDeadlinePassed = koreaTime.isAfter(endOfDay);
  }

  void setupTimer(VoidCallback onDeadlineReached) {
    _timer?.cancel();
    _onDeadlineReached = onDeadlineReached;

    final koreaTime = _koreaTime;
    final endOfDay = _endOfDay;
    final difference = endOfDay.difference(koreaTime);

    if (difference.isNegative) {
      _isDeadlinePassed = true;
      return;
    }

    _timer = Timer(difference, () {
      _isDeadlinePassed = true;
      _onDeadlineReached?.call();
    });
  }

  String calculateTimeRemaining() {
    final koreaTime = _koreaTime;
    final endOfDay = _endOfDay;

    final difference = endOfDay.difference(koreaTime);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    if (hours >= 1) {
      return '$hours시간';
    } else {
      return '$minutes분';
    }
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _onDeadlineReached = null;
  }
}

String calculateTimeRemaining() {
  final deadlineManager = DeadlineManager();
  return deadlineManager.calculateTimeRemaining();
}

bool isChallengeDeadlinePassed() {
  final deadlineManager = DeadlineManager();
  deadlineManager.checkInitialDeadlineStatus();
  return deadlineManager.isDeadlinePassed;
}
