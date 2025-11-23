import 'package:mongbi_app/features/terms/domain/entities/terms.dart';
import 'package:mongbi_app/features/terms/domain/repositories/terms_repository.dart';

class GetLatestTerms {
  GetLatestTerms(this.repository);
  final TermsRepository repository;

  Future<List<Terms>> call() => repository.getLatestTerms();
}
