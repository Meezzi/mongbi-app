import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';
import 'package:mongbi_app/domain/use_cases/dream_save_use_case.dart';

void main() {
  DreamRepository? dreamRepository;
  DreamSaveUseCase? dreamSaveUseCase;

  group('Dream Save Usecase Test', () {
    setUp(() {
      dreamRepository = MockDreamRepository();
      dreamSaveUseCase = DreamSaveUseCase(dreamRepository!);
    });

    test('should return true when dream is saved successfully', () async {
      // Arrange
      final dream = Dream(
        id: 1,
        createdAt: DateTime.parse('2025-06-03T23:52:56.000Z'),
        uid: 2,
        challengeId: 1,
        content: 'Flying in the sky',
        score: 0,
        dreamKeywords: [],
        dreamInterpretation: 'Dream interpretation',
        psychologicalStateInterpretation:
            'Interpretation of psychological state',
        psychologicalStateKeywords: [],
        mongbiComment: 'happy',
        emotionCategory: 'sad',
      );

      when(
        () => dreamRepository!.saveDream(dream),
      ).thenAnswer((_) async => true);

      // Act
      final response = await dreamSaveUseCase!.saveDream(dream);

      // Assert
      expect(response, isTrue);

      verify(() => dreamRepository!.saveDream(any())).called(1);
    });

    test('should return true when dream is saved successfully', () async {
      // Arrange
      final dream = Dream(
        id: 1,
        createdAt: DateTime.parse('2025-06-03T23:52:56.000Z'),
        uid: 2,
        challengeId: 1,
        content: 'Flying in the sky',
        score: 0,
        dreamKeywords: [],
        dreamInterpretation: 'Dream interpretation',
        psychologicalStateInterpretation:
            'Interpretation of psychological state',
        psychologicalStateKeywords: [],
        mongbiComment: 'happy',
        emotionCategory: 'sad',
      );

      when(
        () => dreamRepository!.saveDream(dream),
      ).thenThrow(Exception('테스트용 오류'));

      // Act
      final response = await dreamRepository!.saveDream(dream);

      // Assert
      expect(response, throwsA(isA<Exception>));
    });
  });
}

class MockDreamRepository extends Mock implements DreamRepository {}
