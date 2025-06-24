import 'package:mongbi_app/domain/repositories/alarm_repository.dart';

class UpdateIsReadStatusUseCase {
  UpdateIsReadStatusUseCase(this.repository);

  AlarmRepository repository;

  Future<bool> execute(int id) async {
    return await repository.updateIsReadStatus(id);
  }
}
