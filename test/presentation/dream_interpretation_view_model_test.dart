import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/use_cases/analyze_and_save_dream_use_case.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_interpretation_view_model.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

void main() {
  late ProviderContainer container;
  late DreamInterpretationViewModel viewModel;

  setUpAll(() {
    registerFallbackValue(FakeDream());
  });

  setUp(() {
    container = ProviderContainer();
    viewModel = container.read(dreamInterpretationViewModelProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('DreamInterpretationViewModel saveDream Test', () {
    test('setDream을 호출하면 상태가 업데이트', () async {
      // Arrange
      final dream = Dream(
        createdAt: DateTime.now(),
        uid: 4,
        challengeId: 0,
        content: '',
        score: 1,
        dreamKeywords: ['테스트'],
        dreamSubTitle: '테스트 해석',
        dreamInterpretation: '테스트 해몽',
        psychologicalSubTitle: '테스트 심리',
        psychologicalStateInterpretation: '심리상태 테스트',
        psychologicalStateKeywords: ['심리'],
        mongbiComment: '몽비 코멘트',
        dreamCategory: '길몽',
      );

      // Act
      viewModel.setDream(dream);

      final state = viewModel.state;

      // Assert
      expect(state.dreamSubTitle, equals(dream.dreamSubTitle));
    });
  });
}

class MockDreamSaveUseCase extends Mock implements AnalyzeAndSaveDreamUseCase {}

class FakeDream extends Fake implements Dream {}
