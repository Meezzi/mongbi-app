import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/save_challenge_data_source.dart';

class RemoteSaveChallengeDataSource implements SaveChallengeDataSource {
  RemoteSaveChallengeDataSource({required this.dio});

  final Dio dio;

  @override
  Future<bool> saveChallenge({
    required int uid,
    required int challengeId,
  }) async {
    try {
      final response = await dio.post(
        '/dreams',
        data: {'USER_IDX': uid, 'CHALLENGE_IDX': challengeId},
      );

      return response.statusCode == 201 && response.data['success'] == true;
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생했습니다.');
    } catch (e) {
      throw Exception('알수 없는 오류가 발생했습니다.');
    }
  }
}
