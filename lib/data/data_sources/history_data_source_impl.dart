import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/data/dtos/history_dto.dart';

class HistoryDataSourceImpl implements HistoryDataSource {
  HistoryDataSourceImpl(Dio dio) {
    _dio = dio;
    _dio.options = BaseOptions(
      baseUrl: 'https://mongbe.store',
      validateStatus: (status) => true,
    );
  }

  late Dio _dio;

  @override
  Future<List<HistoryDto>> fetchAllHistory() async {
    try {
      final response = await _dio.get('');

      if (response.statusCode == 200) {
        print(response);
        final results = List.from(response.data['results']);
        final historyList = results.map((e) => HistoryDto.fromJson(e)).toList();
        return historyList;
      }
      return [];
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}
