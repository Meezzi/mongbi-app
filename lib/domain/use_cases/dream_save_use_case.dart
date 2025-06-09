import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

class DreamSaveUseCase {
  DreamSaveUseCase(this.dreamRepository);

  final DreamRepository dreamRepository;

  Future<bool> saveDream(Dream dream) async {
    return await dreamRepository.saveDream(dream);
  }
}
