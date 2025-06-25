import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_terms_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_terms_repository.dart';
import 'package:mongbi_app/domain/repositories/terms_repository.dart';
import 'package:mongbi_app/domain/use_cases/agree_to_terms_usecase.dart';
import 'package:mongbi_app/domain/use_cases/fetch_terms_use_case.dart';
import 'package:mongbi_app/presentation/terms/viewmodels/terms_viewmodels.dart';
import 'package:mongbi_app/providers/core_providers.dart';

/// 🔹 RemoteDataSource Provider
final _remoteTermsDataSourceProvider = Provider<RemoteTermsDataSource>(
  (ref) => RemoteTermsDataSource(ref.read(adminDioProvider)),
);
final _userTermsDataSourceProvider = Provider<RemoteTermsDataSource>(
  (ref) => RemoteTermsDataSource(ref.read(dioProvider)),
);

final _termsRepositoryProvider = Provider<TermsRepository>(
  (ref) => RemoteTermsRepository(ref.read(_remoteTermsDataSourceProvider)),
);

final getLatestTermsUseCaseProvider = Provider<GetLatestTerms>(
  (ref) => GetLatestTerms(ref.read(_termsRepositoryProvider)),
);

final userTermsRepositoryProvider = Provider<TermsRepository>(
  (ref) => RemoteTermsRepository(ref.read(_userTermsDataSourceProvider)),
);

final agreeToTermsUseCaseProvider = Provider<AgreeToTermsUseCase>(
  (ref) => AgreeToTermsUseCase(ref.read(userTermsRepositoryProvider)),
);

final termsViewModelProvider =
    StateNotifierProvider<TermsViewModel, TermsState>((ref) {
      return TermsViewModel(
        ref.read(getLatestTermsUseCaseProvider),
        ref.read(agreeToTermsUseCaseProvider),
      );
    });
