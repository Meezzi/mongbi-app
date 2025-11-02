import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/use_cases/analyze_and_save_dream_use_case.dart';
import 'package:mongbi_app/domain/use_cases/analyze_dream_use_case.dart';
import 'package:mongbi_app/domain/use_cases/save_dream_use_case.dart';

void main() {
  late MockAnalyzeDreamUseCase mockAnalyzeDreamUseCase;
  late MockSaveDreamUseCase mockSaveDreamUseCase;
  late AnalyzeAndSaveDreamUseCase analyzeAndSaveDreamUseCase;

  setUp(() {
    mockAnalyzeDreamUseCase = MockAnalyzeDreamUseCase();
    mockSaveDreamUseCase = MockSaveDreamUseCase();
    analyzeAndSaveDreamUseCase = AnalyzeAndSaveDreamUseCase(
      mockAnalyzeDreamUseCase,
      mockSaveDreamUseCase,
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
      () => mockAnalyzeDreamUseCase.execute(1, '꿈 내용', 3),
    ).thenAnswer((_) async => dream);

    when(
      () => mockSaveDreamUseCase.execute(1, dream),
    ).thenAnswer((_) async => 123);

    // Act
    final result = await analyzeAndSaveDreamUseCase.execute(1, '꿈 내용', 3);

    // Assert
    expect(result.id, 123);
    expect(result.content, '꿈 내용');
  });

  test('analyze dream fail test', () {
    // Arrange
    when(
      () => mockAnalyzeDreamUseCase.execute(1, '꿈 내용', 3),
    ).thenThrow(Exception('failure'));

    // Act && Assert
    expect(
      () => analyzeAndSaveDreamUseCase.execute(1, '꿈 내용', 3),
      throwsA(isA<Exception>()),
    );
  });

  test('save dream fail test', () {
    // Arrange
    when(
      () => mockAnalyzeDreamUseCase.execute(1, '꿈 내용', 3),
    ).thenAnswer((_) async => dream);

    when(
      () => mockSaveDreamUseCase.execute(1, dream),
    ).thenThrow(Exception('failure'));

    // Act && Assert
    expect(
      () => analyzeAndSaveDreamUseCase.execute(1, '꿈 내용', 3),
      throwsA(isA<Exception>()),
    );
  });
}

class MockAnalyzeDreamUseCase extends Mock implements AnalyzeDreamUseCase {}

class MockSaveDreamUseCase extends Mock implements SaveDreamUseCase {}
