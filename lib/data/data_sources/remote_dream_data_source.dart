import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/dream_save_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';

class RemoteDreamDataSource implements DreamSaveDataSource {
  RemoteDreamDataSource(this.dio);

  final Dio dio;

  @override
  Future<int> saveDream(DreamDto dream) async {
    try {
      final response = await dio.post('/dreams', data: dream.toJson());
      if (response.statusCode == 201 && response.data['success'] == true) {
        return response.data['data']['DREAM_IDX'] as int;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    }
  }
}
