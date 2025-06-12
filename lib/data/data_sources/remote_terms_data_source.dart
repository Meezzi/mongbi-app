import 'package:dio/dio.dart';
import 'package:mongbi_app/data/dtos/terms_dto.dart';
import 'package:mongbi_app/domain/entities/terms.dart';

class TermsRemoteDataSource {
  final Dio dio;

  TermsRemoteDataSource(this.dio);

  Future<List<Terms>> fetchLatestTerms() async {
    final response = await dio.get('/api/terms/latest-terms');
    final dataList = response.data as List;

    return dataList.map((e) => TermsDto.fromJson(e).toEntity()).toList();
  }
}
