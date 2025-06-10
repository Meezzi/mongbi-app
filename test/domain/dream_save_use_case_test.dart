import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';
import 'package:mongbi_app/domain/use_cases/dream_save_use_case.dart';

class FakeDream extends Fake implements Dream {}

void main() {
  DreamRepository? dreamRepository;
  DreamSaveUseCase? dreamSaveUseCase;

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

  setUpAll(() {
    registerFallbackValue(FakeDream());
  });

  group('Dream Save Usecase Test', () {
    setUp(() {
      dreamRepository = MockDreamRepository();
      dreamSaveUseCase = DreamSaveUseCase(dreamRepository!);
    });

    test('should return true when dream is saved successfully', () async {
      // Arrange
      when(
        () => dreamRepository!.saveDream(dream),
      ).thenAnswer((_) async => true);

      // Act
      final response = await dreamSaveUseCase!.saveDream(dream);

      // Assert
      expect(response, isTrue);
      verify(() => dreamRepository!.saveDream(any())).called(1);
    });

    test('should throw Exception when dream save fails', () async {
      // Arrange
      when(
        () => dreamRepository!.saveDream(dream),
      ).thenThrow(Exception('테스트용 오류'));

      // Act & Assert
      expect(
        () => dreamSaveUseCase!.saveDream(dream),
        throwsA(isA<Exception>()),
      );
      verify(() => dreamRepository!.saveDream(any())).called(1);
    });
  });
}

class MockDreamRepository extends Mock implements DreamRepository {}
