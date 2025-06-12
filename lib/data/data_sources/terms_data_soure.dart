import 'package:mongbi_app/data/dtos/dream_dto.dart';

abstract interface class TermsGetDataSource {
  Future<bool> getTerms(DreamDto dream);
}
