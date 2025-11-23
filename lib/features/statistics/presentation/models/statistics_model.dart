import 'package:mongbi_app/features/statistics/domain/entities/statistics.dart';

class StatisticsModel {
  StatisticsModel({this.month, this.year});

  Statistics? month;
  Statistics? year;

  StatisticsModel copyWith({Statistics? month, Statistics? year}) {
    return StatisticsModel(month: month ?? this.month, year: year ?? this.year);
  }
}
