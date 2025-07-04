import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/repositories/challenge_repository.dart';
import 'package:mongbi_app/domain/use_cases/save_challenge_use_case.dart';

void main() {
  late MockChallengeRepository mockChallengeRepository;
  late SaveChallengeUseCase saveChallengeUseCase;

  setUp(() {
    mockChallengeRepository = MockChallengeRepository();
    saveChallengeUseCase = SaveChallengeUseCase(
      repository: mockChallengeRepository,
    );
  });

  test('챌린지가 성공적으로 저장이 되었는지 테스트', () async {
    // Arrange
    when(
      () => mockChallengeRepository.saveChallenge(
        dreamId: 1,
        uid: 1,
        challengeId: 1,
      ),
    ).thenAnswer((_) async => true);

    // Act
    final result = await saveChallengeUseCase.saveChallenge(
      dreamId: 1,
      uid: 1,
      challengeId: 1,
    );

    // Assert
    expect(result, true);
  });
}

class MockChallengeRepository extends Mock implements ChallengeRepository {}
