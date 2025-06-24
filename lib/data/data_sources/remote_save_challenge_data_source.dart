import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/save_challenge_data_source.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ 추가

class RemoteSaveChallengeDataSource implements SaveChallengeDataSource {
  RemoteSaveChallengeDataSource({required this.dio});

  final Dio dio;

  @override
  Future<bool> saveChallenge({
    required int dreamId,
    required int uid,
    required int challengeId,
  }) async {
    try {
      final response = await dio.post(
        '/dreams/$dreamId/challenge/$challengeId/$uid',
        data: {
          'dream_idx': dreamId,
          'user_idx ': uid,              // ← 공백 있음! 필요 시 수정
          'challenge_idx ': challengeId, // ← 공백 있음! 필요 시 수정
        },
      );

      return response.statusCode == 201 && response.data['success'] == true;
    } on DioException catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('api', 'save_challenge');
          scope.setExtra('dreamId', dreamId);
          scope.setExtra('userId', uid);
          scope.setExtra('challengeId', challengeId);
        },
      );
      throw Exception(e.message ?? '네트워크 오류가 발생했습니다.');
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('api', 'save_challenge');
          scope.setExtra('dreamId', dreamId);
          scope.setExtra('userId', uid);
          scope.setExtra('challengeId', challengeId);
        },
      );
      throw Exception('알 수 없는 오류가 발생했습니다.');
    }
  }
}
