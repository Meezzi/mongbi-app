import 'package:mongbi_app/data/data_sources/remote_terms_data_source.dart';
import 'package:mongbi_app/data/dtos/terms_aggrement_dto.dart';

import 'package:mongbi_app/domain/entities/terms.dart';
import 'package:mongbi_app/domain/repositories/terms_repository.dart';

class RemoteTermsRepository implements TermsRepository {
  RemoteTermsRepository(this.remote);
  final RemoteTermsDataSource remote;

  @override
  Future<List<Terms>> getLatestTerms() async {
    final models = await remote.fetchLatestTerms();
    return models
        .map(
          (m) => Terms(
            id: m.id,
            name: m.name,
            content: m.content,
            type: m.type,
            requirement: m.requirement,
          ),
        )
        .toList();
  }

  @override
  Future<void> postBulkAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  }) {
    return remote.postBulkAgreements(userIdx: userIdx, agreements: agreements);
  }
}
