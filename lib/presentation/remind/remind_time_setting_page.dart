import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({super.key, required this.onChanged});
  final Function(TimeOfDay, String) onChanged;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  final FixedExtentScrollController ampmController =
      FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController hourController =
      FixedExtentScrollController(initialItem: 7);
  final FixedExtentScrollController minuteController =
      FixedExtentScrollController(initialItem: 0);

  final List<String> ampm = ['오전', '오후'];
  final List<String> hours = List.generate(
    12,
    (i) => i + 1 < 10 ? '0${i + 1}' : '${i + 1}',
  );
  final List<String> minutes = List.generate(60, (i) => i < 10 ? '0$i' : '$i');

  int selectedAmPm = 0;
  int selectedHour = 7;
  int selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF4EAFF),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPicker(
              items: ampm,
              controller: ampmController,
              selectedIndex: selectedAmPm,
              onSelected: (index) {
                setState(() => selectedAmPm = index);
                _notifyChange();
              },
              width: 80,
            ),
            _buildPicker(
              items: hours,
              controller: hourController,
              selectedIndex: selectedHour,
              onSelected: (index) {
                setState(() => selectedHour = index);
                _notifyChange();
              },
            ),
            _buildPicker(
              items: minutes,
              controller: minuteController,
              selectedIndex: selectedMinute,
              onSelected: (index) {
                setState(() => selectedMinute = index);
                _notifyChange();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPicker({
    required List<String> items,
    required FixedExtentScrollController controller,
    required int selectedIndex,
    required Function(int) onSelected,
    double width = 60,
  }) {
    return SizedBox(
      width: width,
      height: 188,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 40,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelected,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) {
            Color textColor;
            if (index == selectedIndex) {
              textColor = const Color(0xFF3B136B); 
            } else if ((index - selectedIndex).abs() == 1) {
              textColor = const Color(0xFFA6A1AA);
            } else {
              textColor = const Color(0xFFE6E4E7); 
            }

            return SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  items[index],
                  style: Font.title20.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _notifyChange() {
    final String amPm = ampm[selectedAmPm];
    final int hour = selectedHour + 1;
    final int minute = selectedMinute;

    final realHour =
        amPm == '오후' && hour != 12
            ? hour + 12
            : (amPm == '오전' && hour == 12 ? 0 : hour);

    widget.onChanged(TimeOfDay(hour: realHour, minute: minute), amPm);
  }
}