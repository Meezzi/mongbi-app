import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/remote_save_challenge_data_source.dart';

void main() {
  late MockDio mockDio;
  late RemoteSaveChallengeDataSource saveChallengeDataSource;

  setUp(() {
    mockDio = MockDio();
    saveChallengeDataSource = RemoteSaveChallengeDataSource(dio: mockDio);
  });

  test('성공적으로 챌린지 저장 테스트', () async {
    // Arrange
    final response = {'success': true, 'code': 201, 'message': '꿈 등록에 성공했습니다.'};
    final dreamId = 1;
    final challengeId = 1;
    final uid = 1;

    when(
      () => mockDio.post(
        '/dreams/$dreamId/challenge/$challengeId/$uid',
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: response,
        statusCode: 201,
        requestOptions: RequestOptions(path: '/dreams'),
      ),
    );

    // Act
    final result = await saveChallengeDataSource.saveChallenge(
      dreamId: dreamId,
      uid: uid,
      challengeId: challengeId,
    );

    // Assert
    expect(result, true);
  });
}

class MockDio extends Mock implements Dio {}
