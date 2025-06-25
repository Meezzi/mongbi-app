import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/challenge_detail_data_source.dart';
import 'package:mongbi_app/data/dtos/challenge_dto.dart';

class RemoteChallengeDetailDataSource implements ChallengeDetailDataSource {
  RemoteChallengeDetailDataSource({required this.dio});

  final Dio dio;

  @override
  Future<ChallengeDto> fetchChallengeDetail({required int challengeId}) async {
    try {
      final response = await dio.get('/api/challenges/id/$challengeId');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final challenge = response.data['data'];

        return ChallengeDto.fromJson(challenge);
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    }
  }
}
