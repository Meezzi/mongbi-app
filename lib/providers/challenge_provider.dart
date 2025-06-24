import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_active_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_challenge_detail_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_complete_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_fetch_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_save_challenge_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_challenge_repository.dart';
import 'package:mongbi_app/domain/use_cases/complete_challenge_use_case.dart';
import 'package:mongbi_app/domain/use_cases/fetch_active_challenge_use_case.dart';
import 'package:mongbi_app/domain/use_cases/fetch_challenge_use_case.dart';
import 'package:mongbi_app/domain/use_cases/save_challenge_use_case.dart';
import 'package:mongbi_app/presentation/challenge/view_models/challenge_view_model.dart';
import 'package:mongbi_app/presentation/home/view_models/home_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _fetchChallengeDataSourceProvider = Provider(
  (ref) => RemoteFetchChallengeDataSource(dio: ref.read(adminDioProvider)),
);

final _saveChallengeDataSourceProvider = Provider(
  (ref) => RemoteSaveChallengeDataSource(dio: ref.read(dioProvider)),
);

final _activeChallengeDataSourceProvider = Provider(
  (ref) => RemoteActiveChallengeDataSource(dio: ref.read(dioProvider)),
);

final _challengeDetailDataSourceProvider = Provider(
  (ref) => RemoteChallengeDetailDataSource(dio: ref.read(adminDioProvider)),
);

final _completeChallengeDataSourceProvider = Provider(
  (ref) => RemoteCompleteChallengeDataSource(dio: ref.read(dioProvider)),
);

final _challengeRepositoryProvider = Provider(
  (ref) => RemoteChallengeRepository(
    challengeDataSource: ref.read(_fetchChallengeDataSourceProvider),
    saveChallengeDataSource: ref.read(_saveChallengeDataSourceProvider),
    completeChallengeDataSource: ref.read(_completeChallengeDataSourceProvider),
    activeChallengeDataSource: ref.read(_activeChallengeDataSourceProvider),
    challengeDetailDataSource: ref.read(_challengeDetailDataSourceProvider),
  ),
);

final fetchChallengeUseCaseProvider = Provider(
  (ref) => FetchChallengeUseCase(
    challengeRepository: ref.read(_challengeRepositoryProvider),
  ),
);

final saveChallengeUseCaseProvider = Provider(
  (ref) =>
      SaveChallengeUseCase(repository: ref.read(_challengeRepositoryProvider)),
);

final fetchActiveChallengeUseCaseProvider = Provider(
  (ref) => FetchActiveChallengeUseCase(
    challengeRepository: ref.read(_challengeRepositoryProvider),
  ),
);

final challengeViewModelProvider = AsyncNotifierProvider(
  () => ChallengeViewModel(),
);

final homeViewModelProvider = NotifierProvider(() => HomeViewModel());
