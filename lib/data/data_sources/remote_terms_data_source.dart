import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/terms_data_soure.dart';
import 'package:mongbi_app/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/data/dtos/terms_dto.dart';
import 'package:mongbi_app/domain/entities/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; 

class RemoteTermsDataSource implements TermsDataSource {
  RemoteTermsDataSource(this.dio);
  final Dio dio;

  @override
  Future<List<Terms>> fetchLatestTerms() async {
    try {
      final response = await dio.get('/api/terms/latest-terms');
      final dataList = response.data as List;
      return dataList.map((e) => TermsDto.fromJson(e).toEntity()).toList();
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('api', 'fetch_latest_terms');
        },
      );
      throw Exception('최신 약관을 불러오는 데 실패했습니다.');
    }
  }

  @override
  Future<void> postUserAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  }) async {
    try {
      final payload = {
        'userIdx': userIdx,
        'agreements': agreements.map((e) => e.toJson()).toList(),
      };

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isaggreed', true);

      await dio.post('/terms/agree/bulk', data: payload);
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('api', 'post_user_agreements');
          scope.setExtra('userIdx', userIdx);
          scope.setExtra('agreements', agreements.map((e) => e.toJson()).toList());
        },
      );
      throw Exception('약관 동의 저장 중 오류가 발생했습니다.');
    }
  }
}
