import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/domain/repositories/history_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_user_dreams_history_use_case.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  test('FetchUserDreamsHistoryUseCase test', () async {
    final mockRepository = MockHistoryRepository();
    final fetchAllHistoryUseCase = FetchUserDreamsHistoryUseCase(
      mockRepository,
    );

    when(() {
      return mockRepository.feachUserDreamsHistory();
    }).thenAnswer((invocation) async {
      return [
        History(
          dreamContent: '꿈1',
          dreamScore: 1,
          dreamKeywords: ['꿈1'],
          dreamInterpretation: '꿈1',
          psychologicalStateInterpretation: '꿈1',
          psychologicalStateKeywords: ['꿈1'],
          mongbiComment: '꿈1',
          dreamRegDate: DateTime.now(),
        ),
      ];
    });

    final history = await fetchAllHistoryUseCase.execute();

    expect(history, isA<List<History>>());
    expect(history.first.dreamContent, '꿈1');
  });
}
