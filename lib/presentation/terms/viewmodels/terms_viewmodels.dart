import 'package:flutter/material.dart';
import 'package:mongbi_app/domain/use_cases/fetch_terms_use_case.dart';
import '../../../domain/entities/terms.dart';

class TermsViewModel extends ChangeNotifier {
  final GetLatestTerms useCase;

  TermsViewModel(this.useCase) {
    fetchTerms();
  }

  List<Terms> _terms = [];
  List<Terms> get terms => _terms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchTerms() async {
    _isLoading = true;
    _terms = await useCase();
    notifyListeners();

    try {
      _terms = await useCase();
    } catch (_) {
      _terms = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
