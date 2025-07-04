import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

class SaveDreamUseCase {
  SaveDreamUseCase(this.dreamRepository);

  final DreamRepository dreamRepository;

  Future<int> execute(int uid, Dream dream) async {
    return await dreamRepository.saveDream(dream);
  }
}
