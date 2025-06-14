import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

void main() {
  late MockDreamRepository mockDreamRepository;
  late AnalyzeAndSaveDreamUseCase analyzeAndSaveDreamUseCase;

  setUp(() {
    mockDreamRepository = MockDreamRepository();
    analyzeAndSaveDreamUseCase = AnalyzeAndSaveDreamUseCase(
      mockDreamRepository,
    );
  });

  final dream = Dream(
    createdAt: DateTime.now(),
    uid: 1,
    challengeId: 0,
    content: '꿈 내용',
    score: 3,
    dreamKeywords: [],
    dreamSubTitle: '꿈 소제목',
    dreamInterpretation: '',
    psychologicalSubTitle: '',
    psychologicalStateInterpretation: '',
    psychologicalStateKeywords: [],
    mongbiComment: '',
    dreamCategory: '',
  );

  test('analyze and save dream success test', () async {
    // Arrange
    when(
      () => mockDreamRepository.analyzeDream('꿈 내용', 3),
    ).thenAnswer((_) async => dream);

    when(
      () => mockDreamRepository.saveDream(dream),
    ).thenAnswer((_) async => true);

    // Act
    final result = await analyzeAndSaveDreamUseCase.execute('꿈 내용', 3);

    // Assert
    expect(result, dream);
  });

  test('analyze dream fail test', () {
    // Arrange
    when(
      () => mockDreamRepository.analyzeDream('꿈 내용', 3),
    ).thenThrow(Exception('failure'));

    when(
      () => mockDreamRepository.saveDream(dream),
    ).thenAnswer((_) async => true);

    // Act && Assert
    expect(
      () => analyzeAndSaveDreamUseCase.execute('꿈 내용', 3),
      throwsA(isA<Exception>()),
    );
  });

  test('save dream fail test', () {
    // Arrange
    when(
      () => mockDreamRepository.analyzeDream('꿈 내용', 3),
    ).thenAnswer((_) async => dream);

    when(
      () => mockDreamRepository.saveDream(dream),
    ).thenThrow(Exception('failure'));

    // Act && Assert
    expect(
      () => analyzeAndSaveDreamUseCase.execute('꿈 내용', 3),
      throwsA(isA<Exception>()),
    );
  });
}

class MockDreamRepository extends Mock implements DreamRepository {}
