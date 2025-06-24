import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/complete_challenge_data_source.dart';

class RemoteCompleteChallengeDataSource implements CompleteChallengeDataSource {
  RemoteCompleteChallengeDataSource({required this.dio});

  final Dio dio;

  @override
  Future<bool> completeChallenge({
    required int uid,
    required int challengeId,
    required String challengeStatus,
  }) async {
    try {
      final response = await dio.post(
        '/challenge-status',
        data: {
          'USER_IDX': uid,
          'CHALLENGE_IDX': challengeId,
          'CHALLENGE_STATUS': challengeStatus,
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['success'] == true) {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '챌린지 완료에 실패했습니다.');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생했습니다.');
    } catch (e) {
      throw Exception('알 수 없는 오류가 발생했습니다.');
    }
  }
}
