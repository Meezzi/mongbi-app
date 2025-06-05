import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/dream_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';

void main() {
  DreamDataSource? dreamDataSource;
  RemoteDreamRepository? remoteDreamRepository;

  group('Dream Repository SaveDream Test', () {
    setUp(() {
      dreamDataSource = MockDreamDataSource();
      remoteDreamRepository = RemoteDreamRepository(dreamDataSource);
    });

    test('Return true if dream creation is successful', () async {
      // Arrange
      when(
        () => dreamDataSource!.saveDream(any()),
      ).thenAnswer((_) async => true);

      // Act
      final response = await remoteDreamRepository.saveDream(dream: dream);
    });
  });
}

class MockDreamDataSource extends Mock implements DreamDataSource {}

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
