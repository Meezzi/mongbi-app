import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late RemoteChallengeDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = RemoteChallengeDataSource(dio: mockDio);
  });

  final dreamScore = 1;

  final responseChallenge = [
    {
      'CHALLENGE_ID': 18,
      'CHALLENGE_NAME': '색으로 자유롭게 색칠',
      'CHALLENGE_DESC': '꿈을 떠올릴 때 가장 먼저 떠오르는 색으로 자유롭게 색칠해보세요.',
      'CHALLENGE_TYPE': '감정 표현형',
      'CHALLENGE_TRAIT': dreamScore,
      'IS_COMPLETE': false,
    },
    {
      'CHALLENGE_ID': 22,
      'CHALLENGE_NAME': '색으로 자유롭게 색칠',
      'CHALLENGE_DESC':
          '조용한 공간에서 5분간 눈을 감고 마음속 이미지를 자유롭게 스케치해보세요. 생각없이 손을 따라가 보세요.',
      'CHALLENGE_TYPE': '감각 리셋형',
      'CHALLENGE_TRAIT': dreamScore,
      'IS_COMPLETE': false,
    },
    {
      'CHALLENGE_ID': 17,
      'CHALLENGE_NAME': '색으로 자유롭게 색칠',
      'CHALLENGE_DESC':
          '눈을 감고 1분 동안 아무 생각도 하지 않고 비움을 느껴보세요. 흐름 없이 떠오르는 생각은 그대로 흘려보내세요.',
      'CHALLENGE_TYPE': '심리 안정형',
      'CHALLENGE_TRAIT': dreamScore,
      'IS_COMPLETE': false,
    },
  ];

  test('챌린지가 성공적으로 요청되었는지 테스트', () async {
    // Arrange
    final mockResponse = {
      'success': true,
      'code': 200,
      'data': responseChallenge,
    };

    when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/challenges/trait/$dreamScore'),
        statusCode: 200,
        data: mockResponse,
      ),
    );

    // Act
    final result = await dataSource.fetchChallenge(dreamScore);

    // Assert
    final expected =
        responseChallenge.map((e) => ChallengeDto.fromJson(e)).toList();
    expect(result[0].title, expected[0].title);
  });
}

class MockDio extends Mock implements Dio {}
