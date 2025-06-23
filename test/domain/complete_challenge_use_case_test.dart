import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/repositories/remote_challenge_repository.dart';

void main() {
  late MockRepository mockRepository;
  late CompleteChallengeUseCase completeChallengeUseCase;

  setUp(() {
    mockRepository = MockRepository();
    completeChallengeUseCase = CompleteChallengeUseCase(
      repository: mockRepository,
    );
  });

  final uid = 1;
  final dreamId = 1;
  final challengeId = 1;

  test('챌린지가 성공적으로 완료되었는지 테스트', () async {
    // Arrange
    when(
      () => mockRepository.completeChallenge(
        uid: uid,
        dreamId: dreamId,
        challengeId: challengeId,
      ),
    ).thenAnswer((_) async => true);

    // Act
    final response = await completeChallengeUseCase.completeChallenge(
      uid: uid,
      dreamId: dreamId,
      challengeId: challengeId,
    );

    // Assert
    expect(response, true);
  });
}

class MockRepository extends Mock implements RemoteChallengeRepository {}
