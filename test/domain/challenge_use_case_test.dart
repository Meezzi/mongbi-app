import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';
import 'package:mongbi_app/domain/repositories/challenge_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_challenge_use_case.dart';

void main() {
  late FetchChallengeUseCase fetchChallengeUseCase;
  late ChallengeRepository challengeRepository;

  setUp(() {
    challengeRepository = MockChallengeRepository();
    fetchChallengeUseCase = FetchChallengeUseCase(
      challengeRepository: challengeRepository,
    );
  });

  int dreamScore = 1;

  final challengeList = [
    Challenge(
      id: 18,
      content: '꿈을 떠올릴 때 가장 먼저 떠오르는 색으로 자유롭게 색칠해보세요.',
      type: '감정 표현형',
      dreamScore: dreamScore,
      isComplete: false,
    ),
    Challenge(
      id: 22,
      content: '조용한 공간에서 5분간 눈을 감고 마음속 이미지를 자유롭게 스케치해보세요. 생각없이 손을 따라가 보세요.',
      type: '감각 리셋형',
      dreamScore: dreamScore,
      isComplete: false,
    ),
    Challenge(
      id: 3,
      content: '눈을 감고 1분 동안 아무 생각도 하지 않고 비움을 느껴보세요. 흐름 없이 떠오르는 생각은 그대로 흘려보내세요.',
      type: '심리 안정형',
      dreamScore: dreamScore,
      isComplete: false,
    ),
  ];

  test('챌린지 요청 및 응답 성공 테스트', () async {
    // Arrange
    when(
      () => challengeRepository.fetchChallenge(dreamScore),
    ).thenAnswer((_) async => challengeList);

    // Act
    final result = await fetchChallengeUseCase.execute(dreamScore);

    // Assert
    expect(result[0].content, challengeList[0].content);
  });
}

class MockChallengeRepository extends Mock implements ChallengeRepository {}
