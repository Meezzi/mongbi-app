import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/challenge_data_source.dart';
import 'package:mongbi_app/data/dtos/challenge_dto.dart';

class RemoteChallengeDataSource implements ChallengeDataSource {
  RemoteChallengeDataSource({required this.dio});

  final Dio dio;

  @override
  Future<List<ChallengeDto>> fetchChallenge(int dreamScore) async {
    try {
      final response = await dio.get('/api/challenges/trait/$dreamScore');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final challengeList = List<Map<String, dynamic>>.from(
          response.data['data'],
        );

        return challengeList.map((e) => ChallengeDto.fromJson(e)).toList();
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    }
  }
}
