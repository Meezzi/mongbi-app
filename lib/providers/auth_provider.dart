

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/data/repositories/auth_repository_impl.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/presentation/auth/viewmodels/auth_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final remoteNaverAuthDateSourceProvider = Provider<RemoteNaverAuthDataSource>(
  (ref) => RemoteNaverAuthDataSource(ref.read(dioProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(remoteNaverAuthDateSourceProvider)),
);

final loginWithNaverUseCaseProvider = Provider<LoginWithNaver>(
  (ref) => LoginWithNaver(ref.read(authRepositoryProvider)),
);

final authViewModelProvider =
    NotifierProvider<AuthViewModel, User?>(() => AuthViewModel());
