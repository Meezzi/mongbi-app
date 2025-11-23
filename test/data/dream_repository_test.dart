import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/features/dream/data/data_sources/dream_analysis_data_source.dart';
import 'package:mongbi_app/features/dream/data/data_sources/dream_check_data_source.dart';
import 'package:mongbi_app/features/dream/data/data_sources/dream_save_data_source.dart';
import 'package:mongbi_app/features/dream/data/dtos/dream_dto.dart';
import 'package:mongbi_app/features/dream/data/repositories/remote_dream_repository.dart';
import 'package:mongbi_app/features/dream/domain/entity/dream.dart';

class FakeDreamDto extends Fake implements DreamDto {}

void main() {
  DreamSaveDataSource? dreamSaveDataSource;
  RemoteDreamRepository? remoteDreamRepository;
  MockDreamAnalysisDataSource? dreamAnalysisDataSource;
  MockDreamCheckDataSource? dreamCheckDataSource;

  setUpAll(() {
    registerFallbackValue(FakeDreamDto());
  });

  group('Dream Repository SaveDream Test', () {
    setUp(() {
      dreamSaveDataSource = MockDreamDataSource();
      dreamAnalysisDataSource = MockDreamAnalysisDataSource();
      dreamCheckDataSource = MockDreamCheckDataSource();
      remoteDreamRepository = RemoteDreamRepository(
        dreamSaveDataSource!,
        dreamAnalysisDataSource!,
        dreamCheckDataSource!,
      );
    });

    test('Return true if dream creation is successful', () async {
      // Arrange
      when(
        () => dreamSaveDataSource!.saveDream(any()),
      ).thenAnswer((_) async => 123);

      // Act
      final response = await remoteDreamRepository?.saveDream(dream);

      // Assert
      expect(response, 123);
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
      dreamCheckDataSource = MockDreamCheckDataSource();
      remoteDreamRepository = RemoteDreamRepository(
        dreamSaveDataSource!,
        dreamAnalysisDataSource!,
        dreamCheckDataSource!,
      );
    });

    test('DreamAnalysisDataSource에서 결과를 받아서 반환해야 한다', () async {
      // Arrange
      final uid = 1;
      final dreamContent = '';
      final dreamScore = 4;

      final fakeAnalysisResult = {
        'dreamKeywords': ['keyword1', 'keyword2'],
        'psychologicalKeywords': ['state1', 'state2'],
        'dreamSubTitle': '금빛 용이 나오는 꿈이라...',
        'dreamInterpretation': '해몽',
        'psychologicalSubTitle': '요즘 무언가 인정받고 싶어?',
        'psychologicalStateInterpretation': '심리 해석',
        'mongbiComment': '몽비의 조언',
        'dreamCategory': '길몽',
      };

      when(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
      ).thenAnswer((_) async => fakeAnalysisResult);

      // Act
      final response = await remoteDreamRepository!.analyzeDream(
        uid,
        dreamContent,
        dreamScore,
      );

      // Assert
      expect(response.dreamInterpretation, '해몽');
      expect(response.psychologicalStateInterpretation, '심리 해석');
      verify(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
      ).called(1);
    });

    test('DreamAnalysisDataSource에서 오류가 전달되면 호출한 곳에 오류를 전달한다.', () async {
      // Arrange
      final uid = 1;
      final dreamContent = '';
      final dreamScore = 4;

      when(
        () => dreamAnalysisDataSource!.analyzeDream(dreamContent, dreamScore),
      ).thenThrow(Exception());

      // Act & Assert
      expect(
        () =>
            remoteDreamRepository!.analyzeDream(uid, dreamContent, dreamScore),
        throwsA(isA<Exception>()),
      );
    });
  });
}

class MockDreamDataSource extends Mock implements DreamSaveDataSource {}

class MockDreamAnalysisDataSource extends Mock
    implements DreamAnalysisDataSource {}

class MockDreamCheckDataSource extends Mock implements DreamCheckDataSource {}

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
