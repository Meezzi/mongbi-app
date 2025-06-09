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

    final history = await fetchAllHistoryUseCase.execute();

    expect(history, isA<List<History>>());
    expect(history.first.dreamContent, '꿈1');
  });
}
