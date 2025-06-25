import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/account_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_account_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_account_repository.dart';
import 'package:mongbi_app/domain/repositories/account_repository.dart';
import 'package:mongbi_app/domain/use_cases/remove_account_use_case.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _accountDataSourceProvider = Provider<AccountDataSource>((ref) {
  final dio = ref.read(dioProvider);
  final secureStorageService = ref.read(secureStorageServiceProvider);
  return RemoteAccountDataSource(dio, secureStorageService);
});

final _accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final dataSource = ref.read(_accountDataSourceProvider);
  return RemoteAccountRepository(dataSource);
});

final removeAccountUseCaseProvider = Provider((ref) {
  final repository = ref.read(_accountRepositoryProvider);
  return RemoveAccountUseCase(repository);
});
