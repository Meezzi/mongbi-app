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
    final response = {'success': true, 'message': '상태가 성공적으로 변경되었습니다.'};

    final uid = 1;
    final challengeId = 1;
    final challengeStatus = 'COMPLETED';

    when(
      () => mockDio.patch('/challenge-status', data: any(named: 'data')),
    ).thenAnswer(
      (_) async => Response(
        data: response,
        statusCode: 201,
        requestOptions: RequestOptions(path: '/challenge-status'),
      ),
    );

    // Act
    final result = await remoteCompleteChallengeDataSource.completeChallenge(
      uid: uid,
      challengeId: challengeId,
      challengeStatus: challengeStatus,
    );

    // Assert
    expect(result, true);
  });
}

class MockDio extends Mock implements Dio {}
