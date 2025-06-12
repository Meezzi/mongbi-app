import 'package:mongbi_app/data/data_sources/remote_terms_data_source.dart';

import '../../domain/entities/terms.dart';
import '../../domain/repositories/terms_repository.dart';

class TermsRepositoryImpl implements TermsRepository {
  final TermsRemoteDataSource remote;

  TermsRepositoryImpl(this.remote);

  @override
  Future<List<Terms>> getLatestTerms() async {
    final models = await remote.fetchLatestTerms();
    return models.map((m) => Terms(
      id: m.id,
      name: m.name,
      content: m.content,
      type: m.type,
      requirement: m.requirement
    )).toList();
  }
}
