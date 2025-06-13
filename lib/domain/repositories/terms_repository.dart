import 'package:mongbi_app/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/domain/entities/terms.dart';

abstract class TermsRepository {
  Future<List<Terms>> getLatestTerms();

  Future<void> postBulkAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  });
}
