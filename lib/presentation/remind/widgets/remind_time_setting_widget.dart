import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemindTimePicker extends StatelessWidget {

  const RemindTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
  });
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
        initialDateTime: _timeOfDayToDateTime(initialTime),
        minuteInterval: 1,
        onDateTimeChanged: (newDateTime) {
          onTimeSelected(TimeOfDay.fromDateTime(newDateTime));
        },
      ),
    );
  }

  DateTime _timeOfDayToDateTime(TimeOfDay tod) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }
}
