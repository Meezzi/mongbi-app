import 'package:mongbi_app/features/dream/domain/entity/dream.dart';
import 'package:mongbi_app/features/dream/domain/repositoreis/dream_repository.dart';

class AnalyzeDreamUseCase {
  AnalyzeDreamUseCase(this.dreamRepository);

  final DreamRepository dreamRepository;

  Future<Dream> execute(int uid, String dreamContent, int dreamScore) async {
    return await dreamRepository.analyzeDream(uid, dreamContent, dreamScore);
  }
}
