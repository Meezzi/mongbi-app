import '../entities/terms.dart';

abstract class TermsRepository {
  Future<List<Terms>> getLatestTerms();
}
