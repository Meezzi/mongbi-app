import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_analysis_data_source.dart';

void main() {
  late RemoteDreamAnalysisDataSource dataSource;
  late MockDio mockDio;

  const apiKey = 'test-api-key';
  const baseUrl = '';
  const dreamContent = '꿈에서 용이 나왔어요.';
  const dreamScore = 4;

  setUp(() {
    mockDio = MockDio();
    dataSource = RemoteDreamAnalysisDataSource(
      dio: mockDio,
      apiKey: apiKey,
      baseUrl: baseUrl,
    );
  });

  group('Dream Analysis DataSource 테스트', () {
    test('성공적으로 응답을 받으면 해석 텍스트를 반환한다', () async {
      // Arrange
      const expectedText = '꿈 해석 결과입니다.';

      final mockResponseData = {
        'content': [
          {'text': expectedText},
        ],
      };

      when(
        () => mockDio.post(
          any(),
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: mockResponseData,
        ),
      );

      // Act
      final result = await dataSource.analyzeDream(dreamContent, dreamScore);

      // Assert
      expect(result, expectedText);
    });

    test('에러 응답 코드가 오면 Exception을 던진다', () async {
      // Arrange
      when(
        () => mockDio.post(
          any(),
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      expect(
        () => dataSource.analyzeDream(dreamContent, dreamScore),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'description',
            contains('API Key가 잘못되었습니다'),
          ),
        ),
      );
    });
  });
}

class MockDio extends Mock implements Dio {}
