import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';

class MockDio extends Mock implements Dio {}

void main() {
  // 테스트 목표
  // 1. 정상적으로 저장이 되어야 한다.
  // 2. 필요한 매개변수는 uid, content, score, keyword
  // 3. 저장이 완료되면 해당 꿈을 반환한다.
  group('DreamDataSource test', () {
    late MockDio mockDio;
    late RemoteDreamDataSource remoteDreamDataSource;

    setUp(() {
      mockDio = MockDio();
      remoteDreamDataSource = RemoteDreamDataSource(mockDio);
    });

    test('Return true if dream creation is successful', () async {
      // Arrange
      final dreamData = DreamDto(
        dreamIdx: 1,
        dreamRegDate: DateTime.parse('2025-06-03T23:52:56.000Z'),
        userIdx: 2,
        challengeIdx: 1,
        dreamContent: 'Flying in the sky',
        dreamScore: 0,
        dreamKeywords: [],
        dreamInterpretation: 'Dream interpretation',
        psychologicalStateInterpretation:
            'Interpretation of psychological state',
        psychologicalStateKeywords: [],
        mongbiComment: 'happy',
        dreamCategory: 'sad',
      );

      final fakeResponse = Response(
        requestOptions: RequestOptions(path: '/dreams'),
        data: {'success': true, 'code': 201, 'message': '꿈 등록에 성공했습니다.'},
        statusCode: 201,
      );

      when(
        () => mockDio.post('/dreams', data: any(named: 'data')),
      ).thenAnswer((_) async => fakeResponse);

      // Act
      final dream = await remoteDreamDataSource.saveDream(dreamData);

      // Assert
      expect(dream, isTrue);
    });

    test('Throws an Exception when dream creation fails', () async {
      // Arrange
      final dreamData = DreamDto(
        dreamIdx: 1,
        dreamRegDate: DateTime.parse('2025-06-03T23:52:56.000Z'),
        userIdx: 2,
        challengeIdx: 1,
        dreamContent: 'Flying in the sky',
        dreamScore: 0,
        dreamKeywords: [],
        dreamInterpretation: 'Dream interpretation',
        psychologicalStateInterpretation:
            'Interpretation of psychological state',
        psychologicalStateKeywords: [],
        mongbiComment: 'happy',
        dreamCategory: 'sad',
      );

      final fakeResponse = Response(
        requestOptions: RequestOptions(path: '/dreams'),
        data: {'success': false, 'code': 404, 'message': '모든 필드는 필수입니다.'},
        statusCode: 404,
      );

      when(
        () => mockDio.post('/dreams', data: any(named: 'data')),
      ).thenAnswer((_) async => fakeResponse);

      // Act & Assert
      expect(
        () async => await remoteDreamDataSource.saveDream(dreamData),
        throwsA(isA<Exception>()),
      );
    });
  });
}
