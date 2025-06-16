class PickerModel {
  PickerModel({DateTime? focusedMonth, DateTime? focusedYear}) {
    this.focusedMonth = focusedMonth ?? DateTime.now();
    this.focusedYear = focusedYear ?? DateTime.now();
  }

  late DateTime focusedMonth;
  late DateTime focusedYear;

  PickerModel copyWith({DateTime? focusedMonth, DateTime? focusedYear}) {
    return PickerModel(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      focusedYear: focusedYear ?? this.focusedYear,
    );
  }

  @override
  String toString() {
    return '''{
      focusedMonth: $focusedMonth, 
      focusedYear: $focusedYear,
    }''';
  }
}
