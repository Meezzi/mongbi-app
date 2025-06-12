class StatisticsModel {
  StatisticsModel({DateTime? focusedDay, this.selectedDay}) {
    this.focusedDay = focusedDay ?? DateTime.now();
  }

  DateTime? selectedDay;
  late DateTime focusedDay;

  StatisticsModel copyWith({DateTime? focusedDay, DateTime? selectedDay}) {
    return StatisticsModel(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  String toString() {
    return '''{
      focusedDay: $focusedDay, 
      selectedDay: $selectedDay,
    }''';
  }
}
