import 'package:mongbi_app/features/terms/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/features/terms/domain/repositories/terms_repository.dart';

class AgreeToTermsUseCase {
  AgreeToTermsUseCase(this.repository);
  final TermsRepository repository;

  Future<void> call({
    required int userIdx,
    required List<AgreementDto> agreements,
  }) async {
    await repository.postBulkAgreements(
      userIdx: userIdx,
      agreements: agreements,
    );
  }
}
