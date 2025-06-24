import 'package:mongbi_app/domain/entities/alarm.dart';
import 'package:mongbi_app/domain/repositories/alarm_repository.dart';

class FetchAlarmsUseCase {
  FetchAlarmsUseCase(this.repository);

  AlarmRepository repository;

  Future<List<Alarm>?> execute() async {
    return await repository.fetchAlarms();
  }
}
