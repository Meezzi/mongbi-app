import 'package:dio/dio.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';

class RemoteDreamDataSource {
  RemoteDreamDataSource(this.dio);

  final Dio dio;

  Future<bool> saveDream(DreamDto dream) async {
    final response = await dio.post('/dreams', data: dream.toJson());
    if (response.statusCode == 201 && response.data['success'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
