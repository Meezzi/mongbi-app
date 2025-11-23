import 'package:mongbi_app/features/terms/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/features/terms/domain/entities/terms.dart';

abstract interface class TermsDataSource {
  Future<List<Terms>> fetchLatestTerms();

  Future<void> postUserAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  });
}
