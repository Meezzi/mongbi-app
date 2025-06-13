import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/dtos/terms_aggrement_dto.dart';
import 'package:mongbi_app/domain/entities/terms.dart';
import 'package:mongbi_app/domain/use_cases/agree_to_terms_usecase.dart';
import 'package:mongbi_app/domain/use_cases/fetch_terms_use_case.dart';

class TermsState {

  const TermsState({required this.terms});
  final List<Terms> terms;

  TermsState copyWith({List<Terms>? terms}) {
    return TermsState(terms: terms ?? this.terms);
  }
}
class TermsViewModel extends StateNotifier<TermsState> {

  TermsViewModel(this._getLatestTermsUseCase, this._agreeToTermsUseCase)
      : super(const TermsState(terms: []));
  final GetLatestTerms _getLatestTermsUseCase;
  final AgreeToTermsUseCase _agreeToTermsUseCase;

  Future<void> fetchTerms() async {
    final termsList = await _getLatestTermsUseCase();
    state = state.copyWith(terms: termsList);
  }

  Future<void> submitAgreements({
    required int userIdx,
    required List<AgreementDto> agreements,
  }) async {
    await _agreeToTermsUseCase(userIdx: userIdx, agreements: agreements);
  }
}
