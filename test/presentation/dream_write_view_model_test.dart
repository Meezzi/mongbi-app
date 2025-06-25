import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/use_cases/analyze_and_save_dream_use_case.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_write_view_model.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

void main() {
  late ProviderContainer container;
  late DreamWriteViewModel viewModel;
  late MockAnalyzeAndSaveDreamUseCase mockAnalyzeAndSaveDreamUseCase;

  setUp(() {
    mockAnalyzeAndSaveDreamUseCase = MockAnalyzeAndSaveDreamUseCase();

    container = ProviderContainer(
      overrides: [
        analyzeAndSaveDreamUseCaseProvider.overrideWithValue(
          mockAnalyzeAndSaveDreamUseCase,
        ),
      ],
    );

    viewModel = container.read(dreamWriteViewModelProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  final dream = Dream(
    id: 1,
    createdAt: DateTime.parse('2025-06-03T23:52:56.000Z'),
    uid: 2,
    challengeId: 1,
    content: 'Flying in the sky',
    score: 0,
    dreamKeywords: [],
    dreamSubTitle: '',
    dreamInterpretation: 'Dream interpretation',
    psychologicalSubTitle: '',
    psychologicalStateInterpretation: 'Interpretation of psychological state',
    psychologicalStateKeywords: [],
    mongbiComment: 'happy',
    dreamCategory: 'sad',
  );

  group('DreamWriteViewModel Test', () {
    test('setDreamContent Test', () {
      // Act
      viewModel.setDreamContent('A new dream');

      // Assert
      expect(
        container.read(dreamWriteViewModelProvider).dreamContent,
        'A new dream',
      );
    });

    test('setSelectedIndex Test', () {
      // Act
      viewModel.setSelectedIndex(2);

      // Assert
      expect(container.read(dreamWriteViewModelProvider).selectedIndex, 2);
    });

    test('setFocused Test', () {
      // Act
      viewModel.setFocused(true);

      // Assert
      expect(container.read(dreamWriteViewModelProvider).isFocused, true);
    });

    test('조건 만족하면 analyzeAndSaveDreamUseCase 실행 & setDream 호출', () async {
      // Arrange
      viewModel.setDreamContent('Test content');
      viewModel.setSelectedIndex(1);

      when(
        () => mockAnalyzeAndSaveDreamUseCase.execute(any(), any()),
      ).thenAnswer((_) async => dream);

      // Act
      await viewModel.submitDream();

      // Assert
      verify(
        () => mockAnalyzeAndSaveDreamUseCase.execute('Test content', 1),
      ).called(1);
    });
  });
}

class MockAnalyzeAndSaveDreamUseCase extends Mock
    implements AnalyzeAndSaveDreamUseCase {}
