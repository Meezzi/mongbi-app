import 'package:mongbi_app/features/dream/domain/entity/dream.dart';
import 'package:mongbi_app/features/dream/domain/repositoreis/dream_repository.dart';

class SaveDreamUseCase {
  SaveDreamUseCase(this.dreamRepository);

  final DreamRepository dreamRepository;

  Future<int> execute(int uid, Dream dream) async {
    return await dreamRepository.saveDream(dream);
  }
}
