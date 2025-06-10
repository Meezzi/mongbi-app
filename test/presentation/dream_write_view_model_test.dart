import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/use_cases/analyze_dream_use_case.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_write_view_model.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

void main() {
  late ProviderContainer container;
  late DreamWriteViewModel viewModel;
  late MockAnalyzeDreamUseCase mockAnalyzeDreamUseCase;

  setUp(() {
    mockAnalyzeDreamUseCase = MockAnalyzeDreamUseCase();

    container = ProviderContainer(
      overrides: [
        analyzDreamUseCaseProvider.overrideWithValue(mockAnalyzeDreamUseCase),
      ],
    );

    viewModel = container.read(dreamWriteViewModelProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  final dream = Dream(
    id: 1,
    createdAt: DateTime.now(),
    uid: 1,
    challengeId: 1,
    content: 'Test content',
    score: 5,
    dreamKeywords: [],
    dreamInterpretation: 'Interpretation',
    psychologicalStateInterpretation: 'State Interpretation',
    psychologicalStateKeywords: [],
    mongbiComment: 'Advice',
    dreamCategory: 'Category',
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

    test('이모티콘을 선택하지 않았을 경우 false 반환', () {
      // Arrange
      viewModel.setDreamContent('Test content');
      viewModel.setSelectedIndex(-1);

      // Act
      final result = viewModel.submitDream();

      // Assert
      expect(result, isFalse);
      verifyNever(() => mockAnalyzeDreamUseCase.execute(any(), any()));
    });

    test('꿈을 작성하고, 이모티콘을 선택한 경우 true 반환', () {
      // Arrange
      viewModel.setDreamContent('Test content');
      viewModel.setSelectedIndex(1);

      when(
        () => mockAnalyzeDreamUseCase.execute(any(), any()),
      ).thenAnswer((_) async => dream);

      // Act
      final result = viewModel.submitDream();

      // Assert
      expect(result, isTrue);
      verify(
        () => mockAnalyzeDreamUseCase.execute('Test content', 1),
      ).called(1);
    });
  });
}

class MockAnalyzeDreamUseCase extends Mock implements AnalyzeDreamUseCase {}
