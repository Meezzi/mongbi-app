import 'package:mongbi_app/domain/repositories/alarm_repository.dart';

class UpdateConfirmStatusUseCase {
  UpdateConfirmStatusUseCase(this.repository);

  AlarmRepository repository;

  Future<bool> execute(int id) async {
    return await repository.updateConfirmStatus(id);
  }
}
