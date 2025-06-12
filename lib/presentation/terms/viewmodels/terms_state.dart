import 'package:mongbi_app/domain/entities/terms.dart';

enum TermsStateStatus { loading, success, error }

class TermsState {
  final TermsStateStatus status;
  final List<Terms> terms;
  final String? error;

  const TermsState({
    required this.status,
    this.terms = const [],
    this.error,
  });

  factory TermsState.loading() => TermsState(status: TermsStateStatus.loading);
  factory TermsState.success(List<Terms> data) =>
      TermsState(status: TermsStateStatus.success, terms: data);
  factory TermsState.error(String message) =>
      TermsState(status: TermsStateStatus.error, error: message);
}
