
import 'package:mongbi_app/features/terms/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/features/terms/domain/entities/terms.dart';

abstract class TermsRepository {
  Future<List<Terms>> getLatestTerms();

  Future<void> postBulkAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  });
}
