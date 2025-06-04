import 'package:flutter_test/flutter_test.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/domain/repositories/history_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_all_history_use_case.dart';

class MockHistoryRepository implements HistoryRepository {
  @override
  Future<List<History>> fetchAllHistory() async {
    return Future.value([
      History(positiveCount: 1, negativeCount: 2, neutralCount: 3),
      History(positiveCount: 4, negativeCount: 5, neutralCount: 6),
    ]);
  }
}

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
    // act
    final history = await fetchAllHistoryUseCase.execute();
    // assert
    expect(history, isA<List<History>>());
    expect(history.length, 2);
    expect(history.first.positiveCount, 1);
  });
}
