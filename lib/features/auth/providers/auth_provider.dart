import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/providers/core_providers.dart';
import 'package:mongbi_app/features/auth/data/data_sources/remote_apple_auth_data_source.dart';
import 'package:mongbi_app/features/auth/data/data_sources/remote_kakao_auth_data_source.dart';
import 'package:mongbi_app/features/auth/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/features/auth/data/dtos/remote_auth_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';
import 'package:mongbi_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/features/auth/domain/use_cases/login_with_apple.dart';
import 'package:mongbi_app/features/auth/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/features/auth/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/features/auth/presentation/view_models/auth_view_model.dart';

final _remoteNaverAuthDataSourceProvider = Provider<RemoteNaverAuthDataSource>(
  (ref) => RemoteNaverAuthDataSource(ref.read(dioProvider)),
);

final _remoteKakaoAuthDataSourceProvider = Provider<RemoteKakaoAuthDataSource>(
  (ref) => RemoteKakaoAuthDataSource(ref.read(dioProvider)),
);

final _remoteAppleAuthDataSourceProvider = Provider<RemoteAppleAuthDataSource>(
  (ref) => RemoteAppleAuthDataSource(ref.read(dioProvider)),
);

final _authRepositoryProvider = Provider<AuthRepository>(
  (ref) => RemoteAuthRepository(
    naverDataSource: ref.read(_remoteNaverAuthDataSourceProvider),
    kakaoDataSource: ref.read(_remoteKakaoAuthDataSourceProvider),
    appleDataSource: ref.read(_remoteAppleAuthDataSourceProvider),
  ),
);

final loginWithNaverUseCaseProvider = Provider<LoginWithNaver>(
  (ref) => LoginWithNaver(ref.read(_authRepositoryProvider)),
);

final loginWithKakaoUseCaseProvider = Provider<LoginWithKakao>(
  (ref) => LoginWithKakao(ref.read(_authRepositoryProvider)),
);

final loginWithAppleUseCaseProvider = Provider<LoginWithApple>(
  (ref) => LoginWithApple(ref.read(_authRepositoryProvider)),
);

final authViewModelProvider = NotifierProvider<AuthViewModel, User?>(
  () => AuthViewModel(),
);
final lastLoginTypeProvider = StateProvider<String?>((ref) => null);