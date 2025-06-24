import 'package:mongbi_app/domain/repositories/dream_repository.dart';

class CanWriteDreamTodayUseCase {
  CanWriteDreamTodayUseCase({required this.repository});

  final DreamRepository repository;

  Future<bool> execute(int uid) async {
    return await repository.canWriteDreamToday(uid);
  }
}
