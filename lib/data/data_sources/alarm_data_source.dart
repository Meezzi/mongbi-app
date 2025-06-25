import 'package:mongbi_app/data/dtos/alarm_dto.dart';

abstract interface class AlarmDataSource {
  Future<List<AlarmDto>?> fetchAlarms();
  Future<bool> updateIsReadStatus(int id);
}
