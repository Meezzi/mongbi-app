import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/domain/repositories/history_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_all_history_use_case.dart';

// class MockHistoryRepository implements HistoryRepository {
//   @override
//   Future<List<History>> fetchAllHistory() async {
// return Future.value([
//   History(dreamContent: '좋은 꿈'),
//   History(dreamContent: '나쁜 꿈'),
// ]);
//   }
// }

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  test('FetchAllHistoryUseCase test', () async {
    // red, green
    // arrange
    // final fetchAllHistoryUseCase = FetchAllHistoryUseCase();
    // act
    // final history = fetchAllHistoryUseCase.execute();
    // assert
    // expect(history, isA<Future<List<History>>>());

    // refactor
    // arrange
    final mockRepository = MockHistoryRepository();
    final fetchAllHistoryUseCase = FetchAllHistoryUseCase(mockRepository);

    when(() {
      return mockRepository.fetchAllHistory();
    }).thenAnswer((invocation) async {
      return [
        History(
          dreamContent: '꿈1',
          dreamScore: 1,
          dreamTag: '꿈1',
          dreamKeywords: ['꿈1'],
          dreamInterpretation: '꿈1',
          psychologicalStatelnterpretation: '꿈1',
          psychologicalstateKeywords: ['꿈1'],
          mongbiComment: '꿈1',
          emotionCategory: '꿈1',
        ),
      ];
    });
    // // act
    final history = await fetchAllHistoryUseCase.execute();
    // assert
    expect(history, isA<List<History>>());
    expect(history.first.dreamContent, '꿈1');
  });
}
