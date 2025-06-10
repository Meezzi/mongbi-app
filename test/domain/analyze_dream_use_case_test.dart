import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';
import 'package:mongbi_app/domain/use_cases/analyze_dream_use_case.dart';

void main() {
  late MockDreamRepository mockDreamRepository;
  late AnalyzeDreamUseCase analyzeDreamUseCase;

  setUp(() {
    mockDreamRepository = MockDreamRepository();
    analyzeDreamUseCase = AnalyzeDreamUseCase(mockDreamRepository);
  });

  final dreamContent = '';
  final dreamScore = 4;

  final dream = Dream(
    id: 1,
    createdAt: DateTime.parse('2025-06-03T23:52:56.000Z'),
    uid: 2,
    challengeId: 1,
    content: 'Flying in the sky',
    score: 0,
    dreamKeywords: [],
    dreamInterpretation: 'Dream interpretation',
    psychologicalStateInterpretation: 'Interpretation of psychological state',
    psychologicalStateKeywords: [],
    mongbiComment: 'happy',
    dreamCategory: 'sad',
  );

  group('AnalyzeDreamUseCase Test', () {
    test('성공하면 Dream Entity 반환', () async {
      // Arrange
      when(
        () => mockDreamRepository.analyzeDream(dreamContent, dreamScore),
      ).thenAnswer((_) async => dream);

      // Act
      final result = await analyzeDreamUseCase.execute(
        dreamContent,
        dreamScore,
      );

      // Assert
      expect(result, dream);
      verify(
        () => mockDreamRepository.analyzeDream(dreamContent, dreamScore),
      ).called(1);
    });

    test('실패하면 오류 반환', () async {
      // Arrange
      when(
        () => mockDreamRepository.analyzeDream(dreamContent, dreamScore),
      ).thenThrow(Exception('Analysis failed'));

      // Act & Assert
      expect(
        () => analyzeDreamUseCase.execute(dreamContent, dreamScore),
        throwsA(isA<Exception>()),
      );

      verify(
        () => mockDreamRepository.analyzeDream(dreamContent, dreamScore),
      ).called(1);
    });
  });
}

class MockDreamRepository extends Mock implements DreamRepository {}
