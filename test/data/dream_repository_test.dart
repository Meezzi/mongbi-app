import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/dream_analysis_data_source.dart';
import 'package:mongbi_app/data/data_sources/dream_save_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';
import 'package:mongbi_app/data/repositories/remote_dream_repository.dart';
import 'package:mongbi_app/domain/entities/dream.dart';

class FakeDreamDto extends Fake implements DreamDto {}

void main() {
  DreamSaveDataSource? dreamSaveDataSource;
  RemoteDreamRepository? remoteDreamRepository;
  MockDreamAnalysisDataSource? dreamAnalysisDataSource;

  setUpAll(() {
    registerFallbackValue(FakeDreamDto());
  });

  group('Dream Repository SaveDream Test', () {
    setUp(() {
      dreamSaveDataSource = MockDreamDataSource();
      dreamAnalysisDataSource = MockDreamAnalysisDataSource();
      remoteDreamRepository = RemoteDreamRepository(
        dreamSaveDataSource!,
        dreamAnalysisDataSource!,
      );
    });

    test('Return true if dream creation is successful', () async {
      // Arrange
      when(
        () => dreamSaveDataSource!.saveDream(any()),
      ).thenAnswer((_) async => true);

      // Act
      final response = await remoteDreamRepository?.saveDream(dream);

      // Assert
      expect(response, isTrue);
      verify(() => dreamSaveDataSource!.saveDream(any())).called(1);
    });

    test('Rreturn false if dream creation is failure', () async {
      // Arrange
      when(
        () => dreamSaveDataSource!.saveDream(any()),
      ).thenThrow(Exception('테스트용 오류'));

      // Act & Assert
      expect(
        () => remoteDreamRepository!.saveDream(dream),
        throwsA(isA<Exception>()),
      );

      verify(() => dreamSaveDataSource!.saveDream(any())).called(1);
    });
  });

  group('analyzeDream 테스트', () {
    setUp(() {
      dreamSaveDataSource = MockDreamDataSource();
      dreamAnalysisDataSource = MockDreamAnalysisDataSource();
      remoteDreamRepository = RemoteDreamRepository(
        dreamSaveDataSource!,
        dreamAnalysisDataSource!,
      );
    });

    test('DreamAnalysisDataSource에서 결과를 받아서 반환해야 한다', () async {
      // Arrange
      final dreamContent = '';
      final dreamScore = 4;

      when(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
      ).thenAnswer((_) async => '꿈 해석이다몽');

      // Act
      final response = await remoteDreamRepository!.analyzeDream(
        dreamContent,
        dreamScore,
      );

      // Assert
      expect(response, '꿈 해석이다몽');

      verify(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
      ).called(1);
    });

    test('DreamAnalysisDataSource에서 오류가 전달되면 호출한 곳에 오류를 전달한다.', () async {
      // Arrange
      final dreamContent = '';
      final dreamScore = 4;

      when(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
      ).thenThrow(Exception());

      // Act & Assert
      expect(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
        throwsA(isA<Exception>()),
      );
    });
  });
}

class MockDreamDataSource extends Mock implements DreamSaveDataSource {}

class MockDreamAnalysisDataSource extends Mock
    implements DreamAnalysisDataSource {}

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
  emotionCategory: 'sad',
);
