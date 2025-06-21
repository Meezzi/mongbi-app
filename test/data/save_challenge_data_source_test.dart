import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

    when(() => mockDio.post('/dreams', data: any(named: 'data'))).thenAnswer(
      (_) async => Response(
        data: response,
        statusCode: 201,
        requestOptions: RequestOptions(path: '/dreams'),
      ),
    );

    // Act
    final result = await saveChallengeDataSource.saveChallenge(
      uid: 1,
      challengeId: 1,
    );

    // Assert
    expect(result, true);
  });
}

class MockDio extends Mock implements Dio {}
