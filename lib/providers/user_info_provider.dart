import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_user_info_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_user_info_reposiotory.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/user_info_repository.dart';
import 'package:mongbi_app/domain/use_cases/get_user_info_use_case.dart';
import 'package:mongbi_app/presentation/auth/viewmodels/auth_view_model.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_state.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _userInfoDataSourceProvider = Provider<RemoteUserInfoGetDataSource>(
  (ref) => RemoteUserInfoGetDataSource(ref.read(dioProvider)),
);

final _userInfoRepositoryProvider = Provider<UserInfoRepository>(
  (ref) => RemoteUserInfoRepository(ref.read(_userInfoDataSourceProvider)),
);

final getUserInfoUseCaseProvider = Provider<GetUserInfoUseCase>(
  (ref) => GetUserInfoUseCase(ref.read(_userInfoRepositoryProvider)),
);

final authViewModelProvider = NotifierProvider<AuthViewModel, User?>(
  () => AuthViewModel(),
);

final userInfoDataSourceProvider = Provider<RemoteUserInfoGetDataSource>(
  (ref) => RemoteUserInfoGetDataSource(ref.read(dioProvider)),
);

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>((ref) {
      final dataSource = ref.read(userInfoDataSourceProvider);
      return SplashViewModel(dataSource, ref);
    });

final currentUserProvider = NotifierProvider<CurrentUserNotifier, User?>(
  () => CurrentUserNotifier(),
);

class CurrentUserNotifier extends Notifier<User?> {
  @override
  User? build() {
    return null; // Initial state is null (no user logged in)
  }

  void setUser(User? user) {
    state = user;
  }
}
