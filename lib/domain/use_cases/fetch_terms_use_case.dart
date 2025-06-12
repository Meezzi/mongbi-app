import '../entities/terms.dart';
import '../repositories/terms_repository.dart';

class GetLatestTerms {
  final TermsRepository repository;

  GetLatestTerms(this.repository);

  Future<List<Terms>> call() => repository.getLatestTerms();
}
