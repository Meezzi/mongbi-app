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
}

class MockDio extends Mock implements Dio {}
