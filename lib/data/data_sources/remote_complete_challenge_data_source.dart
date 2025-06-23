import 'package:dio/dio.dart';

class RemoteCompleteChallengeDataSource {
  RemoteCompleteChallengeDataSource({required this.dio});

  final Dio dio;

  Future<bool> completeChallenge({
    required int uid,
    required int dreamId,
    required int challengeId,
  }) async {
    try {
      final response = await dio.post(
        '/api/user-challenges',
        data: {
          'USER_ID': uid,
          'CHALLENGE_ID': challengeId,
          'DREAM_ID': dreamId,
        },
      );

      return response.statusCode == 201 && response.data['success'] == true;
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생했습니다.');
    } catch (e) {
      throw Exception('알수 없는 오류가 발생했습니다.');
    }
  }
}
