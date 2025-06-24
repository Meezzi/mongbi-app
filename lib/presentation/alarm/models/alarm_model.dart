import 'package:mongbi_app/domain/entities/alarm.dart';

enum FilterType { all, remind, challenge, report }

class AlarmModel {
  AlarmModel({
    this.alarmList,
    this.filterType = FilterType.all,
    this.isClear = false,
  });

  List<Alarm>? alarmList;
  FilterType filterType;
  bool isClear;

  AlarmModel copyWith({
    List<Alarm>? alarmList,
    FilterType? filterType,
    bool? isClear,
  }) {
    return AlarmModel(
      alarmList: alarmList ?? this.alarmList,
      filterType: filterType ?? this.filterType,
      isClear: isClear ?? this.isClear,
    );
  }
}
