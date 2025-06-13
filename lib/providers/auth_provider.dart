import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_kakao_auth_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_auth_repository.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/presentation/auth/viewmodels/auth_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _remoteNaverAuthDataSourceProvider = Provider<RemoteNaverAuthDataSource>(
  (ref) => RemoteNaverAuthDataSource(ref.read(dioProvider)),
);

final _remoteKakaoAuthDataSourceProvider = Provider<RemoteKakaoAuthDataSource>(
  (ref) => RemoteKakaoAuthDataSource(ref.read(dioProvider)),
);

final _authRepositoryProvider = Provider<AuthRepository>(
  (ref) => RemoteAuthRepository(
    naverDataSource: ref.read(_remoteNaverAuthDataSourceProvider),
    kakaoDataSource: ref.read(_remoteKakaoAuthDataSourceProvider),
  ),
);

final loginWithNaverUseCaseProvider = Provider<LoginWithNaver>(
  (ref) => LoginWithNaver(ref.read(_authRepositoryProvider)),
);

final loginWithKakaoUseCaseProvider = Provider<LoginWithKakao>(
  (ref) => LoginWithKakao(ref.read(_authRepositoryProvider)),
);

final authViewModelProvider = NotifierProvider<AuthViewModel, User?>(
  () => AuthViewModel(),
);
