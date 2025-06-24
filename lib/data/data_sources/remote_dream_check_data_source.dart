import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/dream_check_data_source.dart';

class RemoteDreamCheckDataSource implements DreamCheckDataSource {
  RemoteDreamCheckDataSource({required this.dio});

  final Dio dio;

  @override
  Future<bool> canWriteDreamToday({required int uid}) async {
    try {
      final response = await dio.get('/dreams/$uid');

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['success'] == true) {
        final List<dynamic> dreamList = response.data['data'];

        if (dreamList.isEmpty) {
          return true;
        }

        final latestDream = dreamList[0];
        final dreamRegDate = DateTime.parse(latestDream['DREAM_REG_DATE']);

        final today = DateTime.now();
        final todayDate = DateTime(today.year, today.month, today.day);
        final dreamDate = DateTime(
          dreamRegDate.year,
          dreamRegDate.month,
          dreamRegDate.day,
        );
        final isToday = todayDate.isAtSameMomentAs(dreamDate);

        return !isToday;
      } else {
        throw Exception(response.data['message'] ?? '꿈 작성 가능 여부 확인에 실패했습니다.');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return true;
      }
      throw Exception(e.message ?? '네트워크 오류가 발생했습니다.');
    }
  }
}
