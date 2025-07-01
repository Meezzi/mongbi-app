import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/active_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/challenge_detail_data_source.dart';
import 'package:mongbi_app/data/data_sources/fetch_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_complete_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_save_challenge_data_source.dart';
import 'package:mongbi_app/data/dtos/challenge_dto.dart';
import 'package:mongbi_app/data/repositories/remote_challenge_repository.dart';

void main() {
  late MockChallengeDataSource challengeDataSource;
  late MockSaveChallengeDataSource mockSaveChallengeDataSource;
  late MockCompleteChallengeDataSource mockCompleteChallengeDataSource;
  late MockActiveChallengeDataSource mockActiveChallengeDataSource;
  late MockChallengeDetailDataSource mockChallengeDetailDataSource;
  late RemoteChallengeRepository remoteChallengeRepository;

  setUp(() {
    challengeDataSource = MockChallengeDataSource();
    mockSaveChallengeDataSource = MockSaveChallengeDataSource();
    mockCompleteChallengeDataSource = MockCompleteChallengeDataSource();
    mockActiveChallengeDataSource = MockActiveChallengeDataSource();
    mockChallengeDetailDataSource = MockChallengeDetailDataSource();
    remoteChallengeRepository = RemoteChallengeRepository(
      challengeDataSource: challengeDataSource,
      saveChallengeDataSource: mockSaveChallengeDataSource,
      completeChallengeDataSource: mockCompleteChallengeDataSource,
      activeChallengeDataSource: mockActiveChallengeDataSource,
      challengeDetailDataSource: mockChallengeDetailDataSource,
    );
  });

  final dreamScore = 1;

  final challengeDtoList = [
    ChallengeDto(
      18,
      '색으로 자유롭게 색칠',
      '꿈을 떠올릴 때 가장 먼저 떠오르는 색으로 자유롭게 색칠해보세요.',
      '감정 표현형',
      dreamScore,
      false,
    ),
    ChallengeDto(
      22,
      '소리 없는 스케치',
      '조용한 공간에서 5분간 눈을 감고 마음속 이미지를 자유롭게 스케치해보세요. 생각없이 손을 따라가 보세요.',
      '감각 리셋형',
      dreamScore,
      false,
    ),
    ChallengeDto(
      3,
      '1분 간의 멍',
      '눈을 감고 1분 동안 아무 생각도 하지 않고 비움을 느껴보세요. 흐름 없이 떠오르는 생각은 그대로 흘려보내세요.',
      '심리 안정형',
      dreamScore,
      false,
    ),
  ];

  final expectedChallengeList =
      challengeDtoList.map((e) => e.toEntity()).toList();

  test('성공적으로 챌린지 응답이 왔는지 테스트', () async {
    // Arrange
    when(
      () => challengeDataSource.fetchChallenge(dreamScore),
    ).thenAnswer((_) async => challengeDtoList);

    // Act
    final result = await remoteChallengeRepository.fetchChallenge(dreamScore);

    // Assert
    expect(result[0].content, expectedChallengeList[0].content);
  });

  test('챌린지 저장이 성공적으로 이루어졌는지 테스트', () async {
    // Arrange
    when(
      () => mockSaveChallengeDataSource.saveChallenge(
        dreamId: 1,
        uid: 1,
        challengeId: 1,
      ),
    ).thenAnswer((_) async => true);

    // Act
    final result = await remoteChallengeRepository.saveChallenge(
      dreamId: 1,
      uid: 1,
      challengeId: 1,
    );

    // Assert
    expect(result, true);
  });

  test('챌린지의 완료 여부를 성공적으로 저장하는지 테스트', () async {
    // Arrange
    when(
      () => mockCompleteChallengeDataSource.completeChallenge(
        uid: 1,
        challengeId: 1,
        challengeStatus: 'COMPLETED',
      ),
    ).thenAnswer((_) async => true);

    // Act
    final response = await remoteChallengeRepository.completeChallenge(
      uid: 1,
      challengeId: 1,
      challengeStatus: 'COMPLETED',
    );

    // Assert
    expect(response, true);
  });
}

class MockChallengeDataSource extends Mock
    implements FetchChallengeDataSource {}

class MockSaveChallengeDataSource extends Mock
    implements RemoteSaveChallengeDataSource {}

class MockCompleteChallengeDataSource extends Mock
    implements RemoteCompleteChallengeDataSource {}

class MockActiveChallengeDataSource extends Mock
    implements ActiveChallengeDataSource {}

class MockChallengeDetailDataSource extends Mock
    implements ChallengeDetailDataSource {}
