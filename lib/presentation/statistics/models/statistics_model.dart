import 'package:mongbi_app/domain/entities/statistics.dart';

class StatisticsModel {
  StatisticsModel({this.month, this.year, this.tabBarIndex = 0});

  Statistics? month;
  Statistics? year;
  int tabBarIndex;

  StatisticsModel copyWith({
    Statistics? month,
    Statistics? year,
    int? tabBarIndex,
  }) {
    return StatisticsModel(
      month: month ?? this.month,
      year: year ?? this.year,
      tabBarIndex: tabBarIndex ?? this.tabBarIndex,
    );
  }
}
