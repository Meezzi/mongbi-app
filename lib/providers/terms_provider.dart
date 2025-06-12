// lib/presentation/terms/providers/terms_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_terms_data_source.dart';
import 'package:mongbi_app/domain/repositories/terms_repository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_terms_use_case.dart'; // 실제 경로 맞춰주세요
import 'package:mongbi_app/data/repositories/terms_repository_impl.dart';
import 'package:mongbi_app/presentation/terms/viewmodels/terms_viewmodels.dart';
import 'package:mongbi_app/presentation/terms/viewmodels/terms_state.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final remoteTermsDataSourceProvider = Provider<TermsRemoteDataSource>(
  (ref) => TermsRemoteDataSource(ref.read(admindioProvider),
));

final termsRepositoryProvider = Provider<TermsRepository>(
  (ref) => TermsRepositoryImpl(ref.read(remoteTermsDataSourceProvider)),
);

final getLatestTermsUseCaseProvider = Provider<GetLatestTerms>(
  (ref) => GetLatestTerms(ref.read(termsRepositoryProvider)),
);

final termsViewModelProvider = ChangeNotifierProvider((ref) =>
    TermsViewModel(ref.read(getLatestTermsUseCaseProvider)));