import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/data/dtos/history_dto.dart';

class RemoteHistoryDataSource implements HistoryDataSource {
  RemoteHistoryDataSource(this._dio);

  final Dio _dio;
  final userIndex = SecureStorageService().getUserIdx();

  @override
  Future<List<HistoryDto>> feachUserDreamsHistory() async {
    try {
      final response = await _dio.get('/dreams/$userIndex');

      if (response.data['code'] == 201 && response.data['success']) {
        final results = List.from(response.data['data']);
        final historyDtoList =
            results.map((e) => HistoryDto.fromJson(e)).toList();
        return historyDtoList;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return [];
    }
  }
}
