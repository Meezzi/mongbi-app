import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/use_cases/analyze_dream_use_case.dart';
import 'package:mongbi_app/domain/use_cases/save_dream_use_case.dart';

class AnalyzeAndSaveDreamUseCase {
  AnalyzeAndSaveDreamUseCase(this.analyzeDreamUseCase, this.saveDreamUseCase);

  final AnalyzeDreamUseCase analyzeDreamUseCase;
  final SaveDreamUseCase saveDreamUseCase;

  Future<Dream> execute(int uid, String dreamContent, int dreamScore) async {
    final dream = await analyzeDreamUseCase.execute(
      uid,
      dreamContent,
      dreamScore,
    );
    final dreamId = await saveDreamUseCase.execute(uid, dream);
    return dream.copyWith(id: dreamId);
  }
}
