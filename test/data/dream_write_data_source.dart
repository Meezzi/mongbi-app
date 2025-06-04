import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  // 테스트 목표
  // 1. 정상적으로 저장이 되어야 한다.
  // 2. 필요한 매개변수는 uid, content, score, keyword
  // 3. 저장이 완료되면 해당 꿈을 반환한다.
  group('DreamDataSource test', () {
    late MockDio mockDio;
    late DreamDataSource dreamDataSource;

    setUp(() {
      mockDio = MockDio();
      dreamDataSource = dreamDataSource(mockDio);
    });

    test('Return true if dream creation is successful', () {
      // Arrange
      final dreamData = DreamDto(
        id: 1,
        createdAt: DateTime.now(),
        uid: 2,
        challenageId: 1,
        content: 'Flying in the sky',
        dreamKeywords: [],
        dreamInterpretation: 'Dream interpretation',
        psychologicalStateInterpretation:
            'Interpretation of psychological state',
        psychologicalStateKeywords: [],
        mongbiComment: 'happy',
        emotionCategory: 'sad',
      );

      final fakeResponse = Response(
        requestOptions: RequestOptions(path: '/dreams'),
        data: {'success': true, 'code': 201, 'message': '꿈 등록에 성공했습니다.'},
        statusCode: 201,
      );

      when(
        () => mockDio.post('/dreams', data: dummyDream),
      ).thenAnswer((_) async => fakeResponse);

      // Act
      final dream = dreamDataSource.saveDream(dreamData);

      // Assert
      expect(dream, dummyDream);
    });
  });
}

final dummyDream = {
  'id': 1,
  'dreamDate': '2025-06-03T23:52:56.000Z',
  'uid': 2,
  'challangeId': 1,
  'dreamContent': 'Flying in the sky',
  'dreamKeywords': [],
  'dreamInterpretation': 'Dream interpretation',
  'psychologicalStateInterpretation': 'Interpretation of psychological state',
  'psychologicalStateKeywords': [],
  'mongbiComment': 'happy',
  'emotionCategory': 'sad',
};
