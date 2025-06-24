import 'package:mongbi_app/domain/entities/alarm.dart';

abstract interface class AlarmRepository {
  Future<List<Alarm>?> fetchAlarms();
  Future<bool> updateConfirmStatus(int id);
}
