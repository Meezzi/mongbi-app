import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/active_challenge_data_source.dart';

class RemoteActiveChallengeDataSource implements ActiveChallengeDataSource {
  RemoteActiveChallengeDataSource({required this.dio});

  final Dio dio;

  @override
  Future<int?> fetchActiveChallengeId({required int uid}) async {
    try {
      final response = await dio.get('/challenge/inprogress/$uid');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'];

        if (dataList.isEmpty) {
          return null;
        }

        return dataList.first['CHALLENGE_IDX'] as int;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    }
  }
}
