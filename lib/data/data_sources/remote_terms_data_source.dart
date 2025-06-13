import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/terms_data_soure.dart';
import 'package:mongbi_app/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/data/dtos/terms_dto.dart';
import 'package:mongbi_app/domain/entities/terms.dart';

class RemoteTermsDataSource implements TermsDataSource {
  RemoteTermsDataSource(this.dio);
  final Dio dio;

  @override
  Future<List<Terms>> fetchLatestTerms() async {
    final response = await dio.get('/api/terms/latest-terms');
    final dataList = response.data as List;

    return dataList.map((e) => TermsDto.fromJson(e).toEntity()).toList();
  }

  @override
  Future<void> postUserAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  }) async {
    final payload = {
      'userIdx': userIdx,
      'agreements': agreements.map((e) => e.toJson()).toList(),
    };

    await dio.post('/terms/agree/bulk', data: payload);
  }
}
