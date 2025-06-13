import 'package:mongbi_app/data/dtos/dream_dto.dart';

abstract interface class TermsDataSource {
  Future<bool> getTerms(DreamDto dream);
}
