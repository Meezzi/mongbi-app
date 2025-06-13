import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_kakao_auth_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/data/repositories/auth_repository_impl.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/presentation/auth/viewmodels/auth_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final remoteNaverAuthDataSourceProvider = Provider<RemoteNaverAuthDataSource>(
  (ref) => RemoteNaverAuthDataSource(ref.read(dioProvider)),
);

final remoteKakaoAuthDataSourceProvider = Provider<RemoteKakaoAuthDataSource>(
  (ref) => RemoteKakaoAuthDataSource(ref.read(dioProvider)),
);


final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    naverDataSource: ref.read(remoteNaverAuthDataSourceProvider),
    kakaoDataSource: ref.read(remoteKakaoAuthDataSourceProvider),
  ),
);

final loginWithNaverUseCaseProvider = Provider<LoginWithNaver>(
  (ref) => LoginWithNaver(ref.read(authRepositoryProvider)),
);

final loginWithKakaoUseCaseProvider = Provider<LoginWithKakao>(
  (ref) => LoginWithKakao(ref.read(authRepositoryProvider)),
);

final authViewModelProvider =
    NotifierProvider<AuthViewModel, User?>(() => AuthViewModel());
