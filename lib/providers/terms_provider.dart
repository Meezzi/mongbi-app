import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_terms_data_source.dart';
import 'package:mongbi_app/domain/repositories/terms_repository.dart';
import 'package:mongbi_app/domain/use_cases/agree_to_terms_usecase.dart';
import 'package:mongbi_app/domain/use_cases/fetch_terms_use_case.dart';
import 'package:mongbi_app/data/repositories/terms_repository_impl.dart';
import 'package:mongbi_app/presentation/terms/viewmodels/terms_viewmodels.dart';
import 'package:mongbi_app/presentation/terms/viewmodels/terms_viewmodels.dart'
    as ts;
import 'package:mongbi_app/providers/core_providers.dart';

/// 🔹 RemoteDataSource Provider
final remoteTermsDataSourceProvider = Provider<TermsRemoteDataSource>(
  (ref) => TermsRemoteDataSource(ref.read(admindioProvider)),
);
final userTermsDataSourceProvider = Provider<TermsRemoteDataSource>(
  (ref) => TermsRemoteDataSource(ref.read(dioProvider)),
);

/// 🔹 Repository Provider
final termsRepositoryProvider = Provider<TermsRepository>(
  (ref) => TermsRepositoryImpl(ref.read(remoteTermsDataSourceProvider)),
);

/// 🔹 UseCase Providers
final getLatestTermsUseCaseProvider = Provider<GetLatestTerms>(
  (ref) => GetLatestTerms(ref.read(termsRepositoryProvider)),
);

final userTermsRepositoryProvider = Provider<TermsRepository>(
  (ref) => TermsRepositoryImpl(ref.read(userTermsDataSourceProvider)),
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
