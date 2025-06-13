import 'package:mongbi_app/domain/entities/terms.dart';

enum TermsStateStatus { loading, success, error }

class TermsState {
  factory TermsState.error(String message) =>
      TermsState(status: TermsStateStatus.error, error: message);
  factory TermsState.success(List<Terms> data) =>
      TermsState(status: TermsStateStatus.success, terms: data);

  factory TermsState.loading() => TermsState(status: TermsStateStatus.loading);

  const TermsState({
    required this.status,
    this.terms = const [],
    this.error,
  });
  final TermsStateStatus status;
  final List<Terms> terms;
  final String? error;
}
