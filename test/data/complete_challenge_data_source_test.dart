import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/remote_complete_challenge_data_source.dart';

void main() {
  late MockDio mockDio;
  late RemoteCompleteChallengeDataSource remoteCompleteChallengeDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteCompleteChallengeDataSource = RemoteCompleteChallengeDataSource(
      dio: mockDio,
    );
  });

  test('챌린지 완료를 성공적으로 저장', () async {
    // Arrange
    final response = {
      'success': true,
      'code': 201,
      'message': '챌린지 완료 저장 성공',
      'data': {'USER_ID': 1, 'CHALLENGE_ID': 3, 'DREAM_ID': 55},
    };

    final uid = 1;
    final challengeId = 1;
    final dreamId = 1;

    when(
      () => mockDio.post('/api/user-challenges', data: any(named: 'data')),
    ).thenAnswer(
      (_) async => Response(
        data: response,
        statusCode: 201,
        requestOptions: RequestOptions(path: '/api/user-challenges'),
      ),
    );

    // Act
    final result = await remoteCompleteChallengeDataSource.completeChallenge(
      uid: uid,
      challengeId: challengeId,
      dreamId: dreamId,
    );

    // Assert
    expect(result, true);
  });
}

class MockDio extends Mock implements Dio {}
