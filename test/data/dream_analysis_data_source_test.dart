import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late RemoteDreamAnalysisDataSourceImpl dataSource;
  late MockDio mockDio;

  const apiKey = 'test-api-key';
  const dreamContent = '꿈에서 용이 나왔어요.';
  const dreamScore = 4;

  setUp(() {
    mockDio = MockDio();
    dataSource = RemoteDreamAnalysisDataSourceImpl(
      dio: mockDio,
      apiKey: apiKey,
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
  });
}

class MockDio extends Mock implements Dio {}
