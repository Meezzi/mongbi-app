import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/data/dtos/history_dto.dart';

class HistoryDataSourceImpl implements HistoryDataSource {
  HistoryDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<HistoryDto>> feachUserDreamsHistory() async {
    try {
      final response = await _dio.get('');

      if (response.statusCode == 201 && response.data['success'] == true) {
        final results = List.from(response.data['results']);
        final historyList = results.map((e) => HistoryDto.fromJson(e)).toList();
        return historyList;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return [];
    }
  }
}
