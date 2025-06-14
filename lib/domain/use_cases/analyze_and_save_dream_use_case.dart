import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

class AnalyzeAndSaveDreamUseCase {
  AnalyzeAndSaveDreamUseCase(this.dreamRepository);

  final DreamRepository dreamRepository;

  Future<Dream> execute(String dreamContent, int dreamScore) async {
    final analyzedDream = await dreamRepository.analyzeDream(
      dreamContent,
      dreamScore,
    );

    final isSaved = await dreamRepository.saveDream(analyzedDream);
    if (!isSaved) {
      throw Exception('꿈 저장에 실패했습니다.');
    }

    return analyzedDream;
  }
}
