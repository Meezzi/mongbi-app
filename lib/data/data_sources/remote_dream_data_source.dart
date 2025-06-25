import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/dream_save_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
        final error = Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
        await Sentry.captureException(error); 
        throw error;
      }
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s); 
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('꿈 저장 중 알 수 없는 오류 발생: $e');
    }
  }
}
