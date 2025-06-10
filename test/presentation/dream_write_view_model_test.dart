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
        analyzeDreamUseCaseProvider.overrideWithValue(mockAnalyzeDreamUseCase),
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
